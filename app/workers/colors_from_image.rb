class ColorsFromImage
  
  @queue = :colors
  
  def self.perform(art_id)
    
    colors = 64
    art = Art.find(art_id)
    
    # Creates the images files, and uploads them to S3 storage
    puts "readed: '#{art.original.versions[:scaled].to_s}'"
    art.image = File.open(art.original.versions[:scaled].to_s, "rb")
    #art.image = File.open(art.original.to_s)
    art.save!
    
    puts 'saving to image completed ...'
    puts 'quantize colors ....'
    #img = Magick::Image.read("#{Rails.root}/public#{art.image}").first
    img = Magick::Image.read(art.original.versions[:scaled].to_s).first
    img = img.quantize(colors)

    hist = img.color_histogram

    pixels = hist.keys.sort_by {|value| hist[value]}.reverse
          
    if img.number_colors < 16
      colors_to_database = img.number_colors
    else
      colors_to_database = 16
    end
    
    # First, we need to clean the actual color relations, if those exists
    ColorRelation.delete_colors_of(art)
    
    colors_to_database.times do |temp|
      color =  "#%02x%02x%02x" % [(pixels[temp].red/256).to_i,(pixels[temp].green/256).to_i,(pixels[temp].blue/256).to_i]
      ColorRelation.add_color_to(art, color)
      puts "added #{color} -> #{art.name}"  
    end

    puts "done!"

  end
  
end