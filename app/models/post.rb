class Post
  
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug
  include Sunspot::Mongoid
  
  attr_accessor :tags
  after_save :create_tags
  
  after_save     :resque_solr_update
  before_destroy :resque_solr_remove
  
  field :language,           :type => String
  
  field :title,              :type => String
  field :description,        :type => String
  field :text,               :type => String
  
  field :promoted,           :type => Boolean,    :default => false
  field :spotlight,          :type => Boolean,    :default => false
  field :publish,            :type => Boolean,    :default => true
  
  mount_uploader :image1,       Image1Uploader
  mount_uploader :image2,       Image1Uploader  
  mount_uploader :image3,       Image1Uploader
  mount_uploader :image4,       Image1Uploader
  mount_uploader :image5,       Image1Uploader

  belongs_to :postcategory
  belongs_to :user
  
  has_many :comments, :as => :commentable
  
  validates_presence_of :title, :description, :text, :language
  
  slug :title
  
  index :slug, unique: true
  
  searchable :auto_index => false, :auto_remove => false do
    text :title, :stored => true
    string :language do 
      language.downcase
    end
    string :title do
      title.downcase
    end
    string :user_id do
      self.user.id.to_s
    end
    string :category_slug
    integer :show_search do 
      # show in search can be false if the user don't publish it
      if self.publish == false
        0   # show to none
      else
        self.user.privacy.sos
      end
    end
  end
  
  def category_slug
    self.postcategory.slug
  end
  
  private
  
  def create_tags
    if tags.nil? == false
      Tagging.delete_all_tags_of_object_as_where_creator(self, 'post', self.user)
      tags_array = tags.split(',')
      tags_array.each do |tag|
        Tagging.new_tag_for(self, tag, 'post', self.user)
      end
    end
  end
  
  protected
    
  def resque_solr_update
    Resque.enqueue(SolrUpdate, "Post", id)
  end

  def resque_solr_remove
    Resque.enqueue(SolrRemove, "Post", id)
  end
  
end