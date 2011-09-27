class Mailfolder
  include Mongoid::Document
  
  field :type, type: String
  
  belongs_to :user
  
  has_many :messages
  
end
