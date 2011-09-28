class Message
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  field :text, type: String
  
  referenced_in :receiver, :class_name => 'User'
  referenced_in :sender,   :class_name => 'User'

  embedded_in :bucket

end
