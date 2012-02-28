# encoding: utf-8
class LogoUploader < CarrierWave::Uploader::Base

  include CarrierWave::RMagick

  # Choose what kind of storage to use for this uploader:
  # storage :file
  #storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  #def store_dir
    # "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  #  "#{mounted_as}/#{model.id}"
  #end
  
  storage :file
  
  def store_dir
    "/opt/public_img/logo/#{model.id}"
  end
  
  def url(version = nil)
    begin
      if version.nil?
        "//img.tabelia.com#{current_path.gsub("/opt/public_img", '')}"
      else
        "//img.tabelia.com#{versions[version].to_s.gsub("/opt/public_img", '')}"
      end
    rescue
      if version.nil?
        "//assets.tabelia.com/assets/fallback/logo_default.jpg"
      else
        "//assets.tabelia.com/assets/fallback/logo_#{version.to_s}_default.jpg"
      end
    end
  end
  
  def default_url
    "/assets/fallback/logo_" + [version_name, "default.jpg"].compact.join('_')
  end

  def filename
    # "avatar.jpg" if original_filename
    "#{random_token}.#{file.extension}" if original_filename.present?
  end

  def random_token
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) or model.instance_variable_set(var, ActiveSupport::SecureRandom.hex(2))
  end

  process :resize_to_fill => [150, 150] 
  process :convert => 'jpg'
  process :quality => 75
    
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
