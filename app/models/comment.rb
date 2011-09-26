class Comment
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  
  referenced_in :receiver, :class_name => 'User'
  referenced_in :author, :class_name => 'User'
  field :text, type: String
  
  validates_length_of :text, minimum: 2
end
