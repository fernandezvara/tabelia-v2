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
      if art != related and art.photo == related.photo
        ArtSimilar.create!(:art_id => art_id, :photo => art.photo, :similar_id => related.id.to_s, :why => 1)
        puts "Added: #{art.name} --> #{related.name}"
      else
        puts "Not Added: #{art.name} --> #{related.name}"
      end 
    end
    
    # Add every art with similar colors
    related_arts_by_color = Array.new
    colors = ColorRelation.colors_of(art)
    colors.each do |color|
      relations = Color.near_colors(color.color.rgb, 1)
      relations.each do |relation|
        temp_art = relation.art
        if related_arts.include?(temp_art) == false
          related_arts_by_color = related_arts_by_color | [temp_art]
        end
      end
    end
    
    related_arts_by_color.each do |related|
      if art != related and art.photo == related.photo
        begin
          ArtSimilar.create!(:art_id => art_id, :photo => art.photo, :similar_id => related.id.to_s, :why => 2)
          puts "Added by color: #{art.name} --> #{related.name}"
        rescue
        end
      else
        puts "Not Added: #{art.name} --> #{related.name}"
      end 
    end
    
  end
end