class Place
  include Mongoid::Document
  include Mongoid::Slug
  include Geocoder::Model::Mongoid
  
  geocoded_by :address
  
  after_validation :geocode #, :if => :changed? or :new?
  
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
  
  # Avatar
  mount_uploader :logo, LogoUploader
  
  validates_presence_of :name
  
  belongs_to :user
  belongs_to :country
  
  slug :name
  
  index :slug
  
  belongs_to :user
  
  def address
    [ street, city, country.name ].compact.join(', ')
  end
end
