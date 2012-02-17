class Place
  include Mongoid::Document
  include Mongoid::Slug
  include Geocoder::Model::Mongoid
  include Sunspot::Mongoid
  
  geocoded_by :address
  
  after_validation :geocode , :if => :street_changed? or :city_changed? or :postalcode_changed? or :country_id_changed?
  after_save     :resque_solr_update
  before_destroy :resque_solr_remove
  
  field :name,         :type => String
  field :place_info,   :type => String
  field :street,       :type => String
  field :city,         :type => String
  field :postalcode,   :type => String
  field :phone1,       :type => String
  field :phone2,       :type => String
  field :email,        :type => String
  field :website,      :type => String
  
  field :coordinates,  :type => Array
  
  field :active,       :type => Boolean,   :default => true
  
  # Avatar
  mount_uploader :logo, LogoUploader
  
  validates_presence_of :name
  
  belongs_to :user
  belongs_to :country
  belongs_to :placecategory
  
  slug :name
  
  index :slug
  
  belongs_to :user
  
  has_many :images, :as => :imageable
  has_many :comments, :as => :commentable
  
  after_save     :resque_solr_update
  before_destroy :resque_solr_remove
  
  searchable :auto_index => false, :auto_remove => false do
    text :name, :stored => true
    string :name do
      name.downcase
    end
    string :user_id do
      self.user.id.to_s
    end
    string :city
    string :postalcode
    string :country_code do 
      country.code.to_s
    end
  end
  
  def address
    [ street, city, country.name ].compact.join(', ')
  end
  
  protected
    
  def resque_solr_update
    Resque.enqueue(SolrUpdate, "Place", id)
  end

  def resque_solr_remove
    Resque.enqueue(SolrRemove, "Place", id)
  end
end
