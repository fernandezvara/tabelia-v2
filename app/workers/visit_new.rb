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
    
    puts visit.inspect
  end
  
end
