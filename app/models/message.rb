class Message
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  field :text, type: String
  
  referenced_in :sender,   :class_name => 'User'

  belongs_to :conversation


  # when we send a new message we create the message, the conversation and the relations between users and conversations
  # we can send a message to an array of users, so every user will have a relation 'Userconversation' for this conversation
  # so a new message makes:
  # 
  # Message.new
  # Conversation.new, subject = subject
  # Conversation.new.messages << Message.new
  # Userconversation.new.user = sender, readed = true, conversation = Conversation.new, save!
  # 
  # For every user receiving this conversation:
  # Userconversation.new.user = receiver, readed = false, conversation = Conversation.new, save!
  #
  def send!(to_array, subject)
    begin
      conversation = Conversation.new
      conversation.subject = subject
    
      conversation.messages << self
    
      self.save!
      conversation.save!
    
      senderconversation = Userconversation.new
      senderconversation.user = self.sender
      senderconversation.readed = true
      senderconversation.conversation = conversation
      senderconversation.hide = false
      senderconversation.save!
    
      to_array.each do |to|
        receiverconversation = Userconversation.new
        receiverconversation.user = to
        receiverconversation.readed = false
        receiverconversation.hide = false
        receiverconversation.conversation = conversation
        receiverconversation.save!
      end
      return true
    rescue
      return false
    end
  end
  
  def reply!(conversation)
    begin
      conversation.messages << self
      self.save!
      conversation.save!
    
      participants = Userconversation.where(:conversation_id => conversation.id.to_s)
    
      participants.each do |participant|
        if participant.user != self.sender
          participant.readed = false
          participant.hide = false
          participant.save!
        end
      end
      
      return true
    rescue
      return false
    end
  end
end
