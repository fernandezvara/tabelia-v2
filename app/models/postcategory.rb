class Postcategory
  
  include Mongoid::Document
  
  field :slug,     :type => String
  field :title,    :type => String, :localize => true
  has_many :posts
  
  index :slug
end
