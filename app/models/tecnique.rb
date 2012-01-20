class Tecnique
  include Mongoid::Document
  
  field :name,    :type => String, :localize => true
  #localized_field :url,    :type => String
  field :slug

  has_many :arts
  
end
