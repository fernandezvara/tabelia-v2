class Category
  include Mongoid::Document
  include Mongoid::I18n
  
  localized_field :name,    :type => String
  localized_field :url,    :type => String
  field :slug

  has_many :arts
end
