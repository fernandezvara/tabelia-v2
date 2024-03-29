require 'nokogiri'
require 'open-uri'

require File.expand_path("../../config/environment", __FILE__)

#url = "http://api.artondemand.eu/getImages.aspx?colId=#{key}&apiKey=98693F4&lang=es"
#puts url
#xml = Nokogiri::XML(open(url))

i = 0
#xml = Nokogiri::XML(File.open('../../../ES_aod.xml'))

xml = Nokogiri::XML(open('http://www.artondemand.es/aod_xml/ES/ES_aod.xml'))

xml.xpath('//products//product').each do |node|
  node.children.each do |product|
    if product.name == 'product_id'
      @product_id = product.children.to_s.to_i
    end
    if product.name == 'product_name'
      @product_name = product.children.to_s
      @product_name.gsub!("<![CDATA[", "")
      @product_name.gsub!("]]>", "")
    end
    if product.name == 'description'
      @product_description = product.children.to_s
      @product_description.gsub!("<![CDATA[", "")
      @product_description.gsub!("]]>", "")
    end
    if product.name == 'imageURL'
      @product_imageURL = product.children.to_s
      @product_imageURL.gsub!("<![CDATA[", "")
      @product_imageURL.gsub!("]]>", "")
    end
    if product.name == "max_height"
      @product_max_height = product.children.to_s
      @product_max_height = ((@product_max_height.gsub!(",", ".")).to_f / 10).round(2)
    end
    if product.name == "max_width"
      @product_max_width = product.children.to_s
      @product_max_width = ((@product_max_width.gsub!(",", ".")).to_f / 10).round(2)
    end
    if product.name == "min_height"
      @product_min_height = product.children.to_s
      @product_min_height = ((@product_min_height.gsub!(",", ".")).to_f / 10).round(2)
    end
    if product.name == "min_width"
      @product_min_width = product.children.to_s
      @product_min_width = ((@product_min_width.gsub!(",", ".")).to_f / 10).round(2)
    end
    node.xpath('.//artist').children.each do |artist_node|
      if artist_node.name == "artist_id"
        @artist_id = artist_node.children.to_s.to_i
      end
      if artist_node.name == "artist_name"
        @artist_name = artist_node.children.to_s
        @artist_name.gsub!("<![CDATA[", "")
        @artist_name.gsub!("]]>", "")
      end
      if artist_node.name == "artist_surname"
        @artist_surname = artist_node.children.to_s
        @artist_surname.gsub!("<![CDATA[", "")
        @artist_surname.gsub!("]]>", "")
      end
    end
    @artistic = false
    @wallcovering = false
    @rigid = false
    node.xpath('.//mediaAllowed').children.each do |media|
      if media.name == "artistic"
        if media.children.to_s == "True"
          @artistic = true
        end
      end
      if media.name == "wallcovering"
        if media.children.to_s == "True"
          @wallcovering = true
        end
      end
      if media.name == "rigid"
        if media.children.to_s == "True"
          @rigid = true
        end
      end
    end
  end
  i = i + 1
  
    puts "#{i}"
    puts "ID: #{@product_id} -> #{@product_name}"
    puts "URL: #{@product_imageURL}"
    puts "Desc: #{@product_description}"
    puts "Max: #{@product_max_width}x#{@product_max_height}"
    puts "Min: #{@product_min_width}x#{@product_min_height}"
    puts "Artist ID: #{@artist_id}. #{@artist_name} #{@artist_surname}"
    
    # Creacion de usuario si no existe
    user = User.where(:aod => true, :aod_id => @artist_id).first
    if user.nil? == true
      # creamos nuevo usuario
      user = User.new
      # usuario AOD
      user.aod = true
      user.aod_id = @artist_id
      user.usertype = 1
      user.country_id = "zz"
      user.name = "#{@artist_name} #{@artist_surname}"
      user.generate_username "#{@artist_name} #{@artist_surname}"
      user.email = "#{user.username}@tabelia.com"
      user.language = "es"
      user.admin = false
      user.confirmed = true
      user.about = ""
      passwd = ""
      8.times do
        passwd << (65 + rand(25)).chr
      end
      user.password = passwd
      user.password_confirmation = passwd
      user.save
      user.privacy.sos = 2
      user.privacy.acp = 2
      user.privacy.mom = false
      user.privacy.mcp = false
      user.privacy.mca = false
      user.privacy.mof = false
      user.privacy.mol = false
      user.save
    end

    # verificamos si existe la obra
    art = Art.where(:aod => true, :aod_id => @product_id).first
    if art.nil? == true
      art = Art.new
      art.aod = true
      art.user = user
      art.aod_id = @product_id
      art.name = @product_name
      art.photo = false 
      # temporalmente todas las obras no son fotos, deben ser cambiadas despues
      art.price = 11.8
      art.max_height = @product_max_height
      art.max_width = @product_max_width
      art.description = @product_description
      art.status = true
      art.accepted = true
      art.status_reason = 0
      art.fotolia = false
      art.aod_min_width = @product_min_width
      art.aod_min_height = @product_min_height
      art.aod_image_url = @product_imageURL
      
      #medias soportadas
      art.mat_artistic = @artistic
      art.mat_wallcovering = @wallcovering
      art.mat_rigid = @rigid
      
      art.remote_aodimage_url = @product_imageURL
      art.save
      
      original = Magick::ImageList.new(art.aodimage.to_s)
      puts "canvas -> begin"
    
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
      #Resque.enqueue(AodThumbs, art.id.to_s)
      Resque.enqueue(ColorsFromImage, art.id.to_s)
      Resque.enqueue(FindSimilarArt, art.id.to_s)
      #Resque.enqueue(CreateCanvas, art.id.to_s)
      
      begin
        u = File.delete(rand_filename)
        if u == 1
          puts "canvas -> File deleted"
        end
      rescue
        puts "canvas -> Error borrando imagen!!!!"
      end
      puts "canvas -> done!"
    end
end

# Ahora metemos las obras en su categoria

# Categorias de arte
# GENEROS! GENRE!
categories = Hash.new

categories['9'] = 'portrait'
categories['10'] = 'landscape'
categories['11'] = 'still-life'
categories['35'] = 'marine'
categories['38'] = 'figure'
categories['39'] = 'religious'
categories['40'] = 'botany'
categories['41'] = 'fauna'
categories['42'] = 'architecture'
categories['43'] = 'cinema'
categories['44'] = 'children'
#categories[''] = 'illustration' # CAtegoria nuestra
#categories[''] = 'regional' # Es necesario saber que categoria es al final
categories['184'] = 'motor'
categories['185'] = 'cartography'


categories.each do |key, value|
  @category = Genre.where(:slug => value).first
  url = "http://api.artondemand.eu/getImages.aspx?colId=#{key}&apiKey=98693F4&lang=es"
  puts url
  xml = Nokogiri::XML(open(url))
  #xml = open(url).read
  #puts xml
  
  xml.xpath('//AODop//result//obra').each do |node|
    @product_id = nil
    node.children.each do |product|
      if product.name == "obraId"
        @product_id = product.children.to_s.to_i
      end
    end

    if @product_id.nil? == false
      art = Art.where(:aod => true, :aod_id => @product_id).first
      if art.nil? == false
        art.photo = false
        art.genre = @category
        art.save if art.changed?
        puts "#{@product_id} > #{art.name} > #{@category.name}"
      else
        puts "product_id = '#{@product_id}' no encontrado."
      end
    end
  end
end


# Categorias de arte
# Categorias! Estilos -> !

categories = Hash.new
categories['98'] = 'gothic'
categories['99'] = 'renaissance'
categories['100'] = 'mannerism'
categories['101'] = 'flemish-school'
categories['102'] = 'baroque'
categories['103'] = 'neoclassicism'
categories['104'] = 'realism'
categories['105'] = 'symbolism'
categories['106'] = 'romanticism'
categories['107'] = 'impresionism'
categories['108'] = 'post-impresionism'
categories['109'] = 'art-nouveau'
categories['110'] = 'contemporary-art' #Siglo XX
categories['111'] = 'contemporary-art' #Contemporaneo

categories['45'] = 'abstract'

categories['112'] = 'naive'
categories['113'] = 'fauvism'
categories['114'] = 'expressionism'
categories['115'] = 'surrealism'
categories['116'] = 'cubism'
categories['117'] = 'futurism'



categories.each do |key, value|
  @category = Category.where(:slug => value).first
  url = "http://api.artondemand.eu/getImages.aspx?colId=#{key}&apiKey=98693F4&lang=es"
  puts url
  xml = Nokogiri::XML(open(url))
  
  xml.xpath('//AODop//result//obra').each do |node|
    @product_id = nil
    node.children.each do |product|
      if product.name == "obraId"
        @product_id = product.children.to_s.to_i
      end
    end

    if @product_id.nil? == false
      art = Art.where(:aod => true, :aod_id => @product_id).first
      if art.nil? == false
        art.photo = false
        art.category = @category
        art.save if art.changed?
        puts "#{@product_id} > #{art.name} > #{@category.name}"
      else
        puts "product_id = '#{@product_id}' no encontrado."
      end
    end
  end
end

# !!!!!!!!!!

# Categorias de foto
categories = Hash.new
categories['132'] = 'landscape'
categories['133'] = 'graphic'
categories['134'] = 'people'
categories['135'] = 'fauna'
categories['136'] = 'botany'
categories['137'] = 'artistic'
categories['139'] = 'urban'
categories['140'] = 'travel'
categories['170'] = 'digital'

categories.each do |key, value|
  @category = Subject.where(:slug => value).first
  url = "http://api.artondemand.eu/getImages.aspx?colId=#{key}&apiKey=98693F4&lang=es"
  puts url
  xml = Nokogiri::XML(open(url))
  #xml = open(url).read
  #puts xml
  
  xml.xpath('//AODop//result//obra').each do |node|
    @product_id = nil
    node.children.each do |product|
      if product.name == "obraId"
        @product_id = product.children.to_s.to_i
      end
    end

    if @product_id.nil? == false
      art = Art.where(:aod => true, :aod_id => @product_id).first
      if art.nil? == false
        art.photo = true
        art.subject = @category
        art.save if art.changed?
        puts "#{@product_id} > #{art.name} > #{@category.name}"
      else
        puts "product_id = '#{@product_id}' no encontrado."
      end
    end
  end
end
