class CreateRecommendations
  
  @queue = :recommendations
  
  # RECOMMENDATIONS TYPES - only record a little number to refer to the explanation
  # 1 - because you like an art of that user
  # 2 - because are authored by an user you follows
  
  def self.perform(who, what, on_what_type, on_what_id)
   # @who = User_id who made the action, who will receive recommendations.
   # @what = What that user have done
   # @on_what_type / @on_what_id = Item that received the action
   
   # recommended_items = Array with items to recommend
   recommended_items = Array.new
   
   puts "----- RECOMMENDATIONS! -----"
   
   case what
   when 'like_art'
     # get all arts from the user that owns 'on_what'
     recommended_items = on_what_type.constantize.find(on_what_id).other_art_of_user(0)
     explanation = 1
   when 'follows_user'
     # get all arts from the user that gets followed
     recommended_items = on_what_type.constantize.find(on_what_id).arts
     explanation = 2
   end
  
  puts "se han recomendado #{recommended_items.count} items."
  
   recommended_items.each do |recommendation|
     if Recommendation.where(:user_id => who, :item_type => recommendation.class.to_s, :item_id => recommendation.id.to_s).count == 0
       case recommendation.class.to_s
       when 'User'
         already_connected = GraphClient.connected?('Forward', 'Follow', User.find(who), recommendation)
       when 'Art'
         already_connected = GraphClient.connected?('Forward', 'Like', User.find(who), recommendation)
       end
       
       if already_connected == false
         new_recommendation = Recommendation.new
         new_recommendation.user_id = who
         new_recommendation.item_type = recommendation.class.to_s
         new_recommendation.item_id = recommendation.id.to_s
         new_recommendation.why = explanation
         new_recommendation.seen = false
         new_recommendation.save!
         puts new_recommendation.inspect
       else
         puts 'already connected!' 
       end
     else
       puts 'already recommended'
     end
   end
  end
end