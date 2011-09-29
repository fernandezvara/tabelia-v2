class Conversation
  include Mongoid::Document
  include Mongoid::Slug
  
  field :subject
  
  slug :subject
  
  has_many :messages
  
  def read!(user)
    relation = Userconversation.where(:user_id => user.id, :conversation_id => self.id).first
    if relation.nil? == true
      return false
    else
      relation.readed = true
      relation.save!
      return true
    end
  end
  
  def last_message
    self.messages.last
  end
  
  def is_participant?(user)
    if Userconversation.where(:user_id => user.id.to_s, :conversation_id => self.id.to_s).count == 1
      return true
    else
      return false
    end
  end
  
  def participants
    relation = Userconversation.where(:conversation_id => self.id.to_s)
    participants = Array.new
    relation.each do |rel|
      participants << rel.user
    end
    return participants
  end
  
  # returns other participants in the conversation that are not the 'user' passed
  def other_participants_than(user)
    relation = Userconversation.where(:conversation_id => self.id.to_s)
    participants = Array.new
    relation.each do |rel|
      if user != rel.user
        participants << rel.user
      end
    end
    return participants
  end
end
