class DeleteCounters
  
  @queue = :statistics
  
  def self.perform(type, receiver_type, receiver_id)
    
    case type
    when 'unfollow'
      if Stat.count(:conditions => {:st_type => receiver_type, :st_id => receiver_id}) == 0
        stat = Stat.create(:st_type => receiver_type, :st_id => receiver_id)
      else
        stat = Stat.where(:st_type => receiver_type, :st_id => receiver_id).first
      end
      stat.unfollows.inc
      stat.save! 
    when 'unlike'
      if Stat.count(:conditions => {:st_type => receiver_type, :st_id => receiver_id}) == 0
        stat = Stat.create(:st_type => receiver_type, :st_id => receiver_id)
      else
        stat = Stat.where(:st_type => receiver_type, :st_id => receiver_id).first
      end
      stat.unlikes.inc
      stat.save!
    end
  end


end