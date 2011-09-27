class Message
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  field :subject, type: String
  field :text,    type: String
  field :readed,  type: Boolean, default: false
  
  belongs_to :mailfolder
  
  referenced_in :receiver, :class_name => 'User'
  referenced_in :sender,   :class_name => 'User'
  
  
  def send!
    to_inbox  = self
    to_outbox = self.clone
    
    self.receiver.inbox.messages << to_inbox
    to_inbox.save!
    
    to_outbox.readed = true
    self.sender.outbox.messages << to_outbox
    to_outbox.save!
  end
end
