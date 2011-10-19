class ColorsFromImage
  
  @queue = :colors
  
  def self.perform(art_id)
    
    colors = 64
    art = Art.find(art_id)
    


    img = Magick::Image.read("#{Rails.root}/public#{art.image}").first
    img = img.quantize(colors)

    hist = img.color_histogram

    pixels = hist.keys.sort_by {|value| hist[value]}.reverse
    
    #pixels.each do |pixel|
    #  puts "#%02x%02x%02x" % [(pixel.red/256).to_i,(pixel.green/256).to_i,(pixel.blue/256).to_i]
    #  puts "#{pixel} - #{hist[pixel]}"
    #end
      
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
    # sort pixels by increasing count
    #pixels = hist.keys.sort_by {|pixel| hist[pixel] }

    #scale = HIST_HEIGHT / (hist.values.max*1.025)   # put 2.5% air at the top

    #gc = Magick::Draw.new
    #gc.stroke_width(1)
    #gc.affine(1, 0, 0, -scale, 0, HIST_HEIGHT)

    # handle images with fewer than NUM_COLORS colors
    #start = NUM_COLORS - img.number_colors

    #pixels.each { |pixel|
    #    gc.stroke(pixel.to_color)
    #    gc.line(start, 0, start, hist[pixel])
    #    start = start.succ
    #}
   
   
    
  end
  
end