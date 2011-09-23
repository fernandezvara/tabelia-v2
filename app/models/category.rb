class Category
  include Mongoid::Document
  include Mongoid::Slug
  
  field :en, :type => String
  field :es, :type => String
  
  slug :en
  
  has_many :arts
end
