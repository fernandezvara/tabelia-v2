class Artcomment
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  
  belongs_to :user
  belongs_to :art
  
  field :text, type: String
  
  validates_length_of :text, minimum: 2
end


