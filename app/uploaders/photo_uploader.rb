# encoding: utf-8
class PhotoUploader < CarrierWave::Uploader::Base

  include CarrierWave::RMagick

  storage :fog

  def store_dir
    # "#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    if version_name
      "#{mounted_as}/#{model.id}"
    else
      "#{mounted_as}_orig/#{model.id}"
    end
  end

  def default_url
    "/assets/fallback/art_" + [version_name, "default.jpg"].compact.join('_')
  end

  def filename
    # "avatar.jpg" if original_filename
    "#{random_token}.jpg" if original_filename.present?
  end

  def random_token
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) or model.instance_variable_set(var, ActiveSupport::SecureRandom.hex(2))
  end
  
  process :convert_to_jpg
  #process :resize_to_fit => [730, 730]
  #process :quality => 70

  version :normal do 
    process :resize_to_fit => [730, 730]
    process :quality => 70
    process :watermark_normal
    process :title_it
  end
  
  version :cart do
    process :resize_to_fit => [300, 300]
    process :quality => 70
    process :watermark_cart
  end

  version :splash do
    process :quality => 70
    process :resize_to_fill => [164, 164]
  end

  version :thumb do
    process :resize_to_fill => [75, 75]
  end

  version :mini do
    process :resize_to_fill => [30, 30]
  end

  def extension_white_list
    %w(jpg jpeg png)
  end
  
  def convert_to_jpg
    puts 'converting to jpg...'
    manipulate!(:format => 'jpg')
  end
  
  def resize_boxed
    # not used, but useful for other time
    manipulate! do |img|
      puts img.columns
      puts img.rows
      if img.columns > img.rows
        if img.columns % img.rows < 100
          img = img.resize_to_fill(165, 165)
        else
          img = img.resize_to_fill(330, 165)
        end
      else
        if img.rows % img.columns < 100 or img.rows == img.columns
          img = img.resize_to_fill(165, 165)
        else
          img = img.resize_to_fill(165, 330)
        end
      end
    end
  end
  
  def title_it
    manipulate! do |img|
      text = Magick::Draw.new
      text.gravity = Magick::SouthEastGravity
      text.pointsize = 14
      text.fill = 'white'
      text.font = "#{Rails.root}/app/assets/images/wm/cabin.ttf"
      text.stroke = 'none'
      text.annotate(img, 0, 0, 0, 0, "© #{model.name} - #{model.user.name}")
      text.gravity = Magick::SouthWestGravity
      text.fill = 'black'
      text.annotate(img, 0, 0, 0, 0, "© #{model.name} - #{model.user.name}")
      img
    end
  end
  
  def watermark_normal
    manipulate! do |img|
      logo = Magick::Image.read(Rails.root + 'app/assets/images/wm/wm-normal.png').first
      center_cols = (img.columns/2) - (logo.columns/2)
      center_rows = (img.rows/2) - (logo.rows/2)
      img = img.dissolve(logo, 0.50, 1, center_cols, center_rows)
    end
  end
  
  def watermark_cart
    manipulate! do |img|
      logo = Magick::Image.read(Rails.root + 'app/assets/images/wm/wm-cart.png').first
      center_cols = (img.columns/2) - (logo.columns/2)
      center_rows = (img.rows/2) - (logo.rows/2)
      img = img.dissolve(logo, 0.50, 1, center_cols, center_rows)
    end
  end
end