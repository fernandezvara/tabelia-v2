class Messageraw
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  field :subject, type: String
  field :text,    type: String

  has_many :messages
  
  referenced_in :receiver, :class_name => 'User'
  referenced_in :sender,   :class_name => 'User'
  
  def send!
    inbox_message =  self.receiver.inbox.messages.create
    outbox_message = self.sender.outbox.messages.create
    
    inbox_message.readed = false
    inbox_message.messageraw = self
    outbox_message.readed = true
    outbox_message.messageraw = self
    
    self.save!
    inbox_message.save!
    outbox_message.save!
  end
  
  def reply!(old_message_id)
    inbox_message =  self.receiver.inbox.messages.create
    outbox_message = self.sender.outbox.messages.create
    
    inbox_message.readed = false
    inbox_message.in_reply_to = old_message_id
    inbox_message.messageraw = self
    outbox_message.readed = true
    outbox_message.in_reply_to = old_message_id
    outbox_message.messageraw = self
    
    self.save!
    inbox_message.save!
    outbox_message.save!
  end
  
end
