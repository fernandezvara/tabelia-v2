# encoding: utf-8
class Art
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug
  include Sunspot::Mongoid
  
  attr_accessor :tags
  
  after_save :create_tags
  
  belongs_to :user
  belongs_to :category    # Style for painting
  belongs_to :genre       # Idiom for painting
  belongs_to :subject     # Subject / Type for photo
  belongs_to :tecnique    # Tecnique for photo
  
  has_many :artcomments
  has_many :color_relations
  has_many :items
  
  field :name,               :type => String,   :presence => true
  field :price,              :type => Integer,  :presence => true
  field :price_a4,           :type => Integer
  field :price_a3,           :type => Integer
  field :price_artistic,     :type => Integer
  field :price_wallcovering, :type => Integer
  field :max_height,         :type => Float
  field :max_width,          :type => Float
  field :description,        :type => String
  field :status,             :type => Boolean,  :default => true
  field :accepted,           :type => Boolean,  :default => false
  field :status_reason,      :type => Integer,  :default => 0
  field :photo,              :type => Boolean,  :default => false
  
  field :m_oil,              :type => Boolean, :default => false             # Óleo
  field :m_watercolor,       :type => Boolean, :default => false             # Acuarela
  field :m_hot_wax,          :type => Boolean, :default => false             # Encaústica
  field :m_pastel,           :type => Boolean, :default => false             # Pastel
  field :m_gouache,          :type => Boolean, :default => false             # Gouache
  field :m_tempera,          :type => Boolean, :default => false             # Témpera
  field :m_ink,              :type => Boolean, :default => false             # Tinta
  field :m_graphite,         :type => Boolean, :default => false             # Grafito
  field :m_charcoal,         :type => Boolean, :default => false             # Carboncillo
  field :m_sepia,            :type => Boolean, :default => false             # Sepia
  field :m_sanguine,         :type => Boolean, :default => false             # Sanguina
  field :m_crayon,           :type => Boolean, :default => false             # Ceras
  field :m_acrylic,          :type => Boolean, :default => false             # Acrílico
  field :m_aerography,       :type => Boolean, :default => false             # Aerografía
  field :m_marker_pen,       :type => Boolean, :default => false             # Rotuladores
  field :m_colored_pencil,   :type => Boolean, :default => false             # Lápices de colores
  field :m_digital,          :type => Boolean, :default => false             # Pintura digital
  field :m_mixed,            :type => Boolean, :default => false             # Técnicas mixtas
  
  #materiales
  field :mat_artistic,       :type => Boolean, :default => false
  field :mat_wallcovering,   :type => Boolean, :default => false
  field :mat_rigid,          :type => Boolean, :default => false
  
  field :exif_manu,          :type => String # Manufacturer
  field :exif_model,         :type => String # Model
  field :exif_expos,         :type => String # Exposure
  field :exif_f,             :type => String # f-factor
  field :exif_iso,           :type => String # ISO
  
  field :fotolia,            :type => Boolean, :default => false
  
  field :popularity,         :type => Float
  
  # art on demand
  field :aod,                :type => Boolean,  :default => false
  field :aod_id,             :type => Integer
  field :aod_min_width,      :type => Float
  field :aod_min_height,     :type => Float
  field :aod_image_url,        :type => String
  
  mount_uploader :aodimage, AodimageUploader
  # art on demand
  
  slug :name
  
  index :slug, unique: true
  index :photo
  index :popularity
  index :aod
  index :aod_id
  
  validates_presence_of :name
  validates_presence_of :price
  validates_numericality_of :price, {:gt => 0}
  
  mount_uploader :image,       ImageUploader
  mount_uploader :original,    OriginalUploader
  
  mount_uploader :canvasimage, CanvasimageUploader
  
  after_save     :resque_solr_update
  before_destroy :resque_solr_remove
  
  searchable :auto_index => false, :auto_remove => false do
    text :name, :stored => true
    string :name do
      name.downcase
    end
    string :user_id do
      self.user.id.to_s if self.user
    end
    integer :show_search do 
      # show in search can be false if the user don't wants to show any art, this art independly or the art haven't
      # be accepted.
      if self.accepted == false or self.status == false
        0   # show to none
      else
        self.user.privacy.sos
      end
    end
    
    boolean :photo
    
    float :popularity
    
    string :category_slug
    string :genre_slug
    string :subject_slug
    string :tecnique_slug
    
    boolean :m_oil
    boolean :m_watercolor
    boolean :m_hot_wax
    boolean :m_pastel
    boolean :m_gouache
    boolean :m_tempera
    boolean :m_ink
    boolean :m_graphite
    boolean :m_charcoal
    boolean :m_sepia
    boolean :m_sanguine
    boolean :m_crayon
    boolean :m_acrylic
    boolean :m_aerography
    boolean :m_marker_pen
    boolean :m_colored_pencil
    boolean :m_digital
    boolean :m_mixed
  end
  
  def category_slug
    begin
      if self.photo == false
       slug = self.category.slug
      else
       slug = ""
      end
    rescue
      slug = ""
    end
    slug
  end
  
  def genre_slug
    begin
      if self.photo == false
        slug = self.genre.slug
      else
        slug = ""
      end
    rescue
      slug = ""
    end
    slug
  end
  
  def subject_slug
    begin
      if self.photo == true
        slug = self.subject.slug
      else
        slug = ""
      end
    rescue
      slug = ""
    end
    slug
  end
  
  def tecnique_slug
    begin
      if self.photo == true
        slug = self.tecnique.slug
      else
        slug = ""
      end
    rescue
      slug = ""
    end
    slug
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
  
  def dimension_correction(width = self.max_width, height = self.max_height)
    width / height
  end
  
  def quote(height, width, aod, media_id, size = nil)
    # devuelve el precio a cobrar en función del tamaño de la reproducción y materiales.
    # Si es una obra de un usuario tabelia, este precio será valorado en función del precio que haya seleccionado
    #   el usuario.
    # Si es una obra de AOD se aplican los precios estimados por estos
    
    # los tamaños no serán usados en este momento, pero pueden ser útiles después
    # para valorar usaremos el media_id, size y aod
    puts "aod = #{aod}"
    puts "media_id = #{media_id}"
    case aod
    when true
      case media_id
      when 2
        quote = 11.8
      when 3
        quote = 11.8
      when 4
        quote = 11.8
      when 5
        case size
        when 's'
          quote = 5.94
        when 'm'
          quote = 8.4
        when 'l'
          quote = 11.8
        end
      when 10
        #wallcovering
        quote = 23.6
      end
    when false
      case media_id
      when 2
        quote = self.price_artistic
      when 3
        quote = self.price_artistic
      when 4
        quote = self.price_artistic
      when 5
        case size
        when 's'
          quote = self.price_a4
        when 'm'
          quote = self.price_a3
        when 'l'
          quote = self.price_artistic
        end
      when 10
        # wallcovering
        quote = self.price_wallcovering
      end
    end
      
    quote.to_f
  end
  
  def get_price(height, width, paper_id, warp = 0, frame = 0)
    #constantes que deberan salir de aqui algun dia    
    # margins, especifica el margen a añadir
    margin = 3
    # paper prices
    papers = Hash.new
    papers[1] = 0.021 # poster 
    papers[2] = 0.037 # foto
    papers[3] = 0.108 # lienzo
    papers[4] = 0.129 # texturado
    papers[5] = 0     # aluminio
    papers[6] = 0     # metacrilato
    papers[99] = 0    # wallcovering
    #coste de bastidor por metro lineal, se tiene por un lado un id para bastidor(warp) y otro para marco(frame)
    cost_warp = 5  # 2 euros per lineal meter
    #aqui iran los costes de los marcos, ahora no tenemos de momento.
    case frame
    when 1
      cost_frame = 0
    end


    # dimensiones
    frame_cms = ((width + height) * 2)
    meters_round = (frame_cms / 100).ceil

    
    # Costes de manipulacion
    case paper_id    # manipullation cost varies from paper type
    when 1
      manipullation_cost = 5
      manipullation_cost_cm = 0.15
    when 2
      manipullation_cost = 3
      manipullation_cost_cm = 0.2
    else
      manipullation_cost = 5
      manipullation_cost_cm = 0.70 # por centimetro
    end
    
    # Coste de tinta
    ink_cm2 = 0.0004
    # Centimetros cuadrados
    cm2 = width * height
    
    # Longitud de papel
    if self.dimension_correction(width, height) == 1
      paper_length = height + (margin * 2)
    else
      if self.dimension_correction(width, height) > 1
        # si la correccion es mayor que uno implica que el ancho es mayor
        paper_length = width + (margin * 2)
      else
        paper_length = height + (margin * 2)
      end
    end
    # Precio papel
    price = papers[paper_id] * paper_length
    
    # Coste de tinta
    price = price + (ink_cm2 * cm2)
    
    # Gastos de manipulacion
    price = price + manipullation_cost
    
    price = price + (paper_length * manipullation_cost_cm)
    
    if warp != 0
      total_warp = cost_warp * meters_round
      price = price + total_warp
    end
    
    if frame != 0
      total_frame = cost_frame * meters_round
      price = price + total_frame
    end
    
    m = manipullation_cost+(paper_length * manipullation_cost_cm)
    puts "Paper lenght: #{paper_length}"
    puts "Tinta: #{(ink_cm2 * cm2)}"
    puts "Papel: #{papers[paper_id] * paper_length}"
    puts "coste total: #{(ink_cm2 * cm2) + (papers[paper_id] * paper_length)}"
    puts "Manipullation costs: #{m}"
    puts "Price: #{price}"
    puts "Margen: #{(m / price)}"
    # returning price
    price
  end
  
  def get_price_fixed(media_id, size, framed)
    puts "media_id = #{media_id},   size = #{size},  framed = #{framed}"
    case media_id.to_i
    when 5
      case size
      when 's'
        result = 25
      when 'm'
        result = 35
      when 'l'
        result = 45
      end
    end
    result
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
