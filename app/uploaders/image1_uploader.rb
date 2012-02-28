# encoding: utf-8
class Image1Uploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick
  #storage :fog

  #def store_dir
  #  "#{mounted_as}/#{model.id}"
  #end
  
  
  storage :file
  
  def store_dir
    "/opt/public_img/post_image/#{model.id}"
  end
  
  def url_path
    "//img.tabelia.com/post_image/#{model.id}"
  end
  
  def default_url
    "/assets/fallback/post_" + [version_name, "default.jpg"].compact.join('_')
  end

  def filename
    "#{random_token}.#{file.extension}" if original_filename.present?
  end

  def random_token
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) or model.instance_variable_set(var, ActiveSupport::SecureRandom.hex(2))
  end

  process :resize_to_fit => [990, 600] 
  process :convert => 'jpg'
  process :quality => 75
  
  version :spotlight do 
    process :resize_to_fill => [450, 320]
    process :quality => 75
  end
  
  version :post do 
    process :resize_to_fill => [600, 250]
    process :quality => 75
  end
  
  version :thumb do
   process :resize_to_fill => [75, 75]
   process :quality => 75
  end
  
  version :mini do
   process :resize_to_fill => [30, 30]
   process :quality => 75
  end

  def extension_white_list
    %w(jpg jpeg png)
  end

end
