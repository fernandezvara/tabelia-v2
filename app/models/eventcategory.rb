class Eventcategory
  include Mongoid::Document

  field :name,    :type => String, :localize => true
  field :slug
  
  has_many :events
end
