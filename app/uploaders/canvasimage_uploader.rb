# encoding: utf-8
class CanvasimageUploader < CarrierWave::Uploader::Base

  include CarrierWave::RMagick

  #storage :fog

  #def store_dir
  #  "#{mounted_as}/#{model.id}"
  #end

  storage :file
  
  def store_dir
    "/opt/public_img/canvas/#{model.id}"
  end
  
  def url_path
    "//img.tabelia.com/canvas/#{model.id}"
  end

  def default_url
    "/assets/fallback/art_" + [version_name, "default.jpg"].compact.join('_')
  end

  def filename
    return "#{random_token}.jpg"
  end

  def random_token
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) or model.instance_variable_set(var, ActiveSupport::SecureRandom.hex(2))
  end
  
  #process :convert => 'png'
  process :quality => 70
  
  def extension_white_list
    %w(jpg jpeg png tif tiff)
  end
  
end