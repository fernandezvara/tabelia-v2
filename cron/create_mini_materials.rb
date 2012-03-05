# encoding: UTF-8

# imagen original
original = Magick::ImageList.new(art.aodimage.to_s)


# foto
# añadimos borde en blanco, rotamos y sombreamos
puts "mini-photo"


# para el mini-canvas podemos coger el canvas ya generado =)
# todas las imágenes deben ser de 90x90
puts "mini-canvas"

canvas = art.canvasimage.to_s
mini_canvas = canvas.crop(canvas.colums - 90, 0, 90, 90)
mini_canvas.write('./mini_canvas.jpg') do
  self.quality = 70
end








# Cleaning...
File.delete('./mini_canvas.jpg')


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