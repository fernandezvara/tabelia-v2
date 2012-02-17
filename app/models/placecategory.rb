class Placecategory
  include Mongoid::Document

  field :slug,     :type => String
  field :title,    :type => String, :localize => true
  
  has_many :places
  
  index :slug
end
