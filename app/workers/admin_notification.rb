class AdminNotification
  
  @queue = :notifications
    
  def self.perform(user_id, art_id)
    user = User.find(user_id)
    art = Art.find(art_id)
    NotifierMailer.admin_art_published(user, art).deliver
  end
end