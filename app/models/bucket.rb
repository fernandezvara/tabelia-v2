class Bucket
  include Mongoid::Document
  
  field :subject, type: String
  
  has_many :conversations
  embeds_many :messages
end
