class SendConfirmation
  
  @queue = :notifications
    
  def self.perform(user_id)
    user = User.find(user_id)
    NotifierMailer.confirmation(user).deliver
  end
end