class AodThumbs
  
  @queue = :aod_thumbs
  
  def self.perform(art_id)

    art = Art.find(art_id)
    art.remote_aodimage_url = art.aod_image_url
    art.save
    
    puts "'#{art.name}' -> thumbs created!"
    
  end
end