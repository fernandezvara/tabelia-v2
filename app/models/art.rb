class Art
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug
  include Sunspot::Mongoid
  
  attr_accessor :tags
  
  after_save :create_tags
  
  belongs_to :user
  belongs_to :category
  
  has_many :artcomments
  has_many :color_relations
  has_many :items
  
  field :name,           :type => String,   :presence => true
  field :price,          :type => Integer,  :presence => true
  field :max_height,     :type => Float
  field :max_width,      :type => Float
  field :description,    :type => String
  field :status,         :type => Integer
  field :accepted,       :type => Boolean,  :default => false
  #field :show_search,    :type => Boolean,  :default => false
  
  slug :name
  
  mount_uploader :image,       ImageUploader
  mount_uploader :original,    OriginalUploader
  
  after_save     :resque_solr_update
  before_destroy :resque_solr_remove
  
  searchable :auto_index => false, :auto_remove => false do
    text :name, :stored => true
    integer :show_search do 
      self.user.privacy.sos
    end
    string :category_slug
  end
  
  def category_slug
    self.category.slug
  end
  
  def other_art_of_user(limit = 0)
    if limit == 0
      Art.where(:user_id => self.user.id.to_s).excludes(:id => self.id.to_s)
    else
      Art.where(:user_id => self.user.id.to_s).excludes(:id => self.id.to_s).limit(limit)
    end
  end
  
  def min_width
	  if self.max_width < self.max_height
	    @width = 20
    elsif self.max_width == self.max_height
      @width = 20
    else
      # height = 20! regla de tres... 20 es al alto máximo como x es al ancho w = (mw * 20)/mh
	    @width = self.max_width * 20.0 / self.max_height
    end
    @width.round(2)
  end
  
  def min_height
    if self.max_height < self.max_width
	    @height = 20
    elsif self.max_height == self.max_width
      @height = 20
    else
      # width = 20! regla de tres... 20 es al ancho máximo como x es al alto h = (mh * 20)/mw
	    @height = self.max_height * 20.0 / self.max_width
    end
    @height.round(2)
  end
  
  def dimension_correction
    self.max_width / self.max_height
  end
  
  def get_price(height, width, paper_id, frame = 0)
    
    # margins, especifica el margen a añadir
    margin = 3
    # paper prices
    paper_1 = 0.12 # Coste lienzo
    paper_2 = 0.16 # Coste papel texturado
    # frame
    frame_cost = 20
    # Costes de manipulacion
    manipullation_cost = 15
    manipullation_cost_cm = 0.30 # por centimetro
    # Coste de tinta
    ink_cm2 = 0.003
    # Centimetros cuadrados
    cm2 = width * height
    
    # Longitud de papel
    if self.dimension_correction == 1
      paper_length = height + (margin * 2)
    else
      if self.dimension_correction > 1
        # si la correccion es mayor que uno implica que el ancho es mayor
        paper_length = width + (margin * 2)
      else
        paper_length = height + (margin * 2)
      end
    end
    # Precio papel
    if paper_id == 1
      price = (paper_length * paper_1)
    else
      price = (paper_length * paper_2)
    end
    
    # Coste de tinta
    price = price + (ink_cm2 * cm2)
    
    # Gastos de manipulacion
    price = price + manipullation_cost
    
    price = price + (paper_length * manipullation_cost_cm)
    
    if frame == 1
      price = price + frame_cost
    end
    
    # returning price
    price
  end
  
  private
  
  def create_tags
    if tags.nil? == false
      Tagging.delete_all_tags_of_object_as_where_creator(self, 'arttag', self.user)
      tags_array = tags.split(',')
      tags_array.each do |tag|
        Tagging.new_tag_for(self, tag, 'arttag', self.user)
      end
    end
  end
  
  protected
    
  def resque_solr_update
    Resque.enqueue(SolrUpdate, "Art", id)
  end

  def resque_solr_remove
    Resque.enqueue(SolrRemove, "Art", id)
  end
end
