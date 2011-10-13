class FindSimilarArt
  
  @queue = :similarart
  
  # WHY:
  #
  # 1 = same tags
  # 2 = same colors
  
  def self.perform(art_id)
    
    art = Art.find(art_id)
    tags = Tagging.of_object_as(art, 'arttag')
    related_arts = Array.new
    
    tags.each do |tag|
      taggings = Tagging.get_objects_with_tag(tag.tag.text, 'arttag')
      taggings.each do |tagging|
        puts "Found: #{tagging.taggable.name}"
        related_arts = related_arts | [tagging.taggable]
      end
    end
    
    # Add every art with the same tag
    ArtSimilar.where(:art_id => art_id).delete_all
    related_arts.each do |related|
      if art != related
        ArtSimilar.create!(:art_id => art_id, :similar_id => related.id.to_s, :why => 1)
        puts "Added: #{art.name} --> #{related.name}"
      else
        puts "Not Added: #{art.name} --> #{related.name}"
      end
        
    end
    
    
  end
  
end