# encoding: utf-8
class CanvasimageUploader < CarrierWave::Uploader::Base

  include CarrierWave::RMagick

  storage :file
  
  def store_dir
    "/opt/public_img/canvas/#{model.id}"
  end
  
  def url(version = nil)
    begin
      if version.nil?
        "//img.tabelia.com#{current_path.gsub("/opt/public_img", '')}"
      else
        "//img.tabelia.com#{versions[version].to_s.gsub("/opt/public_img", '')}"
      end
    rescue
      nil
    end
  end

  def default_url
    "/assets/fallback/art_" + [version_name, "default.jpg"].compact.join('_')
  end

  def filename
    return "image.jpg"
  end

  def random_token
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) or model.instance_variable_set(var, ActiveSupport::SecureRandom.hex(2))
  end
  
  def extension_white_list
    %w(jpg jpeg png tif tiff)
  end  
  
  process :quality => 70
  
  version :small do
    process :resize_to_fit => [165, 165]
  end
end