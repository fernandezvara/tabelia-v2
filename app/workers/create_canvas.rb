class CreateCanvas
  
  @queue = :canvas
  
  def self.perform(art_id)
    
    require 'open-uri'
    art = Art.find(art_id)
    
    if art.aod == true
      original = Magick::ImageList.new
      url = open("#{art.aod_image_url}")
      original.from_blob(url.read)
      puts "image -> aod"
    else
      # Creates the images files, and uploads them to S3 storage
      original = Magick::Image.read(art.original.versions[:scaled].to_s).first
      puts "image -> tabelia"
    end

    valor_corte = (original.columns * 0.02).to_i # cortamos un 5% de la imagen
    valor_shadow = (original.rows * 0.01).to_i # El valor de la sombra lo hacemos proporcinal 400px = 2

    main = original.crop(0,0,original.columns - valor_corte, original.rows)

    lateral = original.crop(original.columns - valor_corte, 0, original.columns, original.rows)
    lateral.background_color = "transparent"
    lateral.virtual_pixel_method = Magick::TransparentVirtualPixelMethod

    lateral_img = Magick::Image.new(lateral.columns + 20, lateral.rows + 20) do 
      self.depth = 8
      self.background_color = "transparent"
    end
    lateral_img.virtual_pixel_method = Magick::TransparentVirtualPixelMethod

    lateral_distorted = lateral_img.composite(lateral.distort(Magick::PerspectiveDistortion, [0,0,0,0, 0,lateral.rows,0,lateral.rows, lateral.columns,0,lateral.columns,15, lateral.columns,lateral.rows,lateral.columns,lateral.rows - 10]),0,0, Magick::OverCompositeOp)
    lateral_distorted.virtual_pixel_method = Magick::TransparentVirtualPixelMethod
    lateral.background_color = "transparent"  

    final = Magick::Image.new(original.columns + 10, original.rows + 10) do 
      self.depth = 8
      self.background_color = "transparent"
    end
    final.virtual_pixel_method = Magick::TransparentVirtualPixelMethod

    final.composite!(lateral_distorted, original.columns - valor_corte, 0, Magick::OverCompositeOp)
    final.composite!(main, 0, 0, Magick::OverCompositeOp)
    # guardamos
    shadow = final.shadow(0,0,valor_shadow,0.4)
    
    new_file = Magick::Image.new(shadow.columns, shadow.rows) do 
      self.depth = 8
      self.background_color = "#fbfbfb"
    end
    new_file.composite!(shadow, 0,0, Magick::OverCompositeOp)
    new_file.composite!(final,  0,0, Magick::OverCompositeOp)
    
    #new_file = shadow.composite(final, 0,0, Magick::OverCompositeOp)
    rand_filename = "#{rand(100000)}.jpg"
    
    new_file.write(rand_filename) do
      self.quality = 70
    end

    art.canvasimage = File.open(rand_filename, "rb")
    art.save
    
    sleep 2
    
    begin
      i = File.delete(rand_filename)
      if i == 1
        puts "fichero borrado"
      end
    rescue
    end
    puts "done!"

  end
  
end