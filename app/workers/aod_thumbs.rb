class AodThumbs
  
  @queue = :aod_thumbs
  
  def self.perform(art_id)

    art = Art.find(art_id)
    art.remote_aodimage_url = @product_imageURL
    art.save
    
    puts "'#{art.name}' -> thumbs created!"
    
  end
end