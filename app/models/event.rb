class Event
  include Mongoid::Document
  include Mongoid::Slug
  include Geocoder::Model::Mongoid
    
  field :start,            :type => Date
  field :finish,           :type => Date
  field :title,            :type => String
  field :description,      :type => String
  
  field :coordinates,      :type => Array
  
  field :publish,          :type => Boolean,      :default => true
  
  validates_presence_of :title, :description
  
  slug :title
  
  index :slug
  index :start
  index :finish
  
  belongs_to :eventcategory
  belongs_to :user
  belongs_to :place
  
  scope :published, where(:publish => true)
    
  scope :today, lambda { where :start.lte => Time.now.utc.beginning_of_day, :finish.gte => Time.now.utc.end_of_day }
  
end
