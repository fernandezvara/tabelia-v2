class VisitNew

  @queue = :statistics
  
  def self.perform(http_referrer, obj_type, obj_id, session_id, user_id)
    
    visit = Visit.new
    
    visit.visited_type = obj_type    # What is visited (User, Art)
    visit.visited_id   = obj_id      # ID
    visit.visitor      = user_id     # Who visited it
    visit.session_id   = session_id
    
    visit.from = http_referrer
    
    visit.save!
    
    
    # Visits counter for today...
    if Stat.count(:conditions => {:st_type => obj_type, :st_id => obj_id}) == 0
      stat = Stat.create(:st_type => obj_type, :st_id => obj_id)
    else
      stat = Stat.where(:st_type => obj_type, :st_id => obj_id).first
    end
    stat.visits.inc

    puts visit.inspect
  end
  
end
