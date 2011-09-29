class Userconversation
  include Mongoid::Document
  include Mongoid::Timestamps::Updated
  
  field :readed, type: Boolean
  field :hide,   type: Boolean, default: false
  # When an user 'deletes' a conversation it only gets hide, so if some other participant send a message to the 
  # conversation that relation is shown again
  
  referenced_in :user
  referenced_in :conversation
  
end
