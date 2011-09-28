class Message
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  field :text, type: String
  
  referenced_in :sender,   :class_name => 'User'

  belongs_to :bucket

  def send!(subject)
    
    b = Bucket.new
    b.subject = subject
    b.messages << self
    
    self.save!
    b.save!
    
    
    
    
    # Creamos la conversation, relaciona bucket con usuario
    conv_receiver = self.receiver.conversations.create
    conv_sender   = self.sender.conversations.create
    # relacionamos el bucket de mensajes con la conversation
    conv_receiver.bucket = b
    conv_sender.bucket = b
    # receiver no ha leido, sender ha leido
    conv_receiver.readed = false
    conv_sender.readed = true
    # guardamos la relation
    conv_sender.save!
    conv_receiver.save!
  end
    
end
