class Bucket
  include Mongoid::Document
  include Mongoid::Slug
  
  field :subject, type: String
  
  slug :subject
  
  has_many :conversations
  has_many :messages
end
