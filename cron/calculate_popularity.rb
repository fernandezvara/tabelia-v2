require File.expand_path("../config/environment", __FILE__)

# Art popularity

hashArtSells =                Hash.new
hashArtComments =             Hash.new
hashArtVisits =               Hash.new
hashArtLikes =                Hash.new

hashArtDaysSincePublication = Hash.new

hashPopularityPoints =        Hash.new

today = Date.new(Time.now.year, Time.now.month, Time.now.day)

Art.all.each do |art|
  hashArtDaysSincePublication[art.id.to_s] = (today - Date.new(art.created_at.year,art.created_at.month,art.created_at.day)).to_i
  if hashArtDaysSincePublication[art.id.to_s] > 0
    hashArtSells[art.id.to_s] = 0.to_f / hashArtDaysSincePublication[art.id.to_s].to_f
    hashArtComments[art.id.to_s] = art.artcomments.count.to_f / hashArtDaysSincePublication[art.id.to_s].to_f
    hashArtLikes[art.id.to_s] =  GraphClient.get_count("Backward", "Like", art).to_f / hashArtDaysSincePublication[art.id.to_s].to_f
    hashArtVisits[art.id.to_s] = Visit.where(:visited_type => 'Art', :visited_id => art.id.to_s).count.to_f / hashArtDaysSincePublication[art.id.to_s].to_f
  end

end

maxLikes     = hashArtLikes.values.max.to_f
maxSells     = hashArtSells.values.max.to_f
maxComments  = hashArtComments.values.max.to_f
maxVisits    = hashArtVisits.values.max.to_f


hashArtVisits.each do |key, value|
  if maxLikes != 0
    hashPopularityPoints[key] = (0.35 * (hashArtLikes[key] / maxLikes))
  else
    hashPopularityPoints[key] = 0
  end
  
  if maxSells != 0
    hashPopularityPoints[key] = hashPopularityPoints[key] + (0.35 * (hashArtSells[key] / maxSells))
  end
  
  if maxComments != 0
    hashPopularityPoints[key] = hashPopularityPoints[key] + (0.15 * (hashArtComments[key] / maxComments)) 
  end
  
  if maxVisits != 0
    hashPopularityPoints[key] = hashPopularityPoints[key] + (0.15 * (hashArtVisits[key] / maxVisits))
  end
  
  puts "popularity for #{Art.find(key).name} = #{hashPopularityPoints[key]}"
  
  if Stat.count(:conditions => {:st_type => 'Art', :st_id => key}) == 0
    stat = Stat.create(:st_type => 'Art', :st_id => key)
  else
    stat = Stat.where(:st_type => 'Art', :st_id => key).first
  end
  stat.popularity.set(hashPopularityPoints[key])
  stat.save!
end

puts "done"