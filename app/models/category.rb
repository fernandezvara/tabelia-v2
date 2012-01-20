class Category
  include Mongoid::Document
  
  field :name,    :type => String, :localize => true
  field :url,     :type => String, :localize => true
  field :slug

  has_many :arts
end
