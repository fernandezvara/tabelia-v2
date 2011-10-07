class UserRanking
  
  def calculate
    
    begining = Time.now.to_i
    
    hashUserScore = Hash.new
    hashUserFollowies = Hash.new
    hashUserFollowing_to_count = Hash.new
    
    users = User.all
    users.each do |user|
      hashUserScore[user.id.to_s] = 1.0
      hashUserFollowies[user.id.to_s] = Array.new
      hashUserFollowing_to_count[user.id.to_s] = GraphClient.get_count("Forward", "Follow", user).to_i
      followies = GraphClient.get("Backward", "Follow", user)
      followies.each do |followie|
        hashUserFollowies[user.id.to_s] << followie.id.to_s
      end
    end
    
    u = User.where(:username => 'reto-continuo').first
    
    100.times do |iteration|
      a = Time.now.to_i
      hashUserScore.each do |key, value|
        pr = 0.15    
        hashUserFollowies[key].each do |followie|
          pr = pr + 0.85*(hashUserScore[followie]/hashUserFollowing_to_count[followie])
        end
        
        hashUserScore[key] = pr
      
      end
     #puts "Iteration: #{iteration}."
     #puts "SCORES:"
     #puts "-------"
     #User.all.each do |user|
     #   puts "#{user.name}: #{hashUserScore[user.id.to_s]}"
     #end
     #puts "TIEMPO EN ESTA ITERACION: #{Time.now.to_i - a} segs."
     #puts "--------------------------------------------------------"
     
     
     puts "#{iteration}. #{u.name}: #{hashUserScore[u.id.to_s]}"
     
    end
    
    #sortedHash = hashUserScore.sort {|a,b| b[1] <=> a[1]}
    #i = 0
    #sortedHash.each do |key, value|
    #  i = i + 1
    #  puts "#{i}. #{User.find(key).name} - #{value} - #{hashUserFollowies[key].count}"
    #end
    
    puts "Total: #{Time.now.to_i - begining} segs"
    
  end
  
  
  
end