class Event
  include Mongoid::Document
  include Mongoid::Slug
  include Geocoder::Model::Mongoid
  
  geocoded_by :address
  
  after_validation :geocode, :if => :place_id_changed?
  
  attr_accessor :place_name, :place_street, :place_city, :place_country_id
  
  field :start,            :type => Date
  field :finish,           :type => Date
  field :title,            :type => String
  field :description,      :type => String
  
  field :coordinates,      :type => Array
  
  field :publish,          :type => Boolean,      :default => true
  
  mount_uploader :image1,       Image1Uploader
  
  validates_presence_of :title
  
  slug :title
  
  index :slug
  index :start
  index :finish
  
  belongs_to :eventcategory
  belongs_to :user
  belongs_to :place
  
  has_many :images, :as => :imageable
  has_many :comments, :as => :commentable
  
  scope :published, where(:publish => true)
    
  scope :today, lambda { where :start.lte => Time.now.utc.beginning_of_day, :finish.gte => Time.now.utc.end_of_day }
  
  def address
    [ place.street, place.city, place.country.name ].compact.join(', ')
  end
  
end
