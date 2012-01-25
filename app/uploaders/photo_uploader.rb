# encoding: utf-8
class PhotoUploader < CarrierWave::Uploader::Base

  include CarrierWave::RMagick

  storage :fog

  def store_dir
    "#{mounted_as}/#{model.id}"
  end

  def default_url
    "//s3-eu-west-1.amazonaws.com/assets.tabelia.com/assets/fallback/art_" + [version_name, "default.jpg"].compact.join('_')
  end

  def filename
    return "#{random_token}.jpg" if original_filename.present?
  end

  def random_token
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) or model.instance_variable_set(var, ActiveSupport::SecureRandom.hex(2))
  end
  
  process :convert_to_jpg
  process :resize_to_fit => [730, 730]
  process :quality => 95

  version :profile do
    process :resize_to_fill => [120, 120]
    process :quality => 80
  end
  
  version :thumb do
    process :resize_to_fill => [75, 75]
    process :quality => 80
  end

  version :mini do
    process :resize_to_fill => [30, 30]
  end

  def extension_white_list
    %w(jpg jpeg png tif tiff)
  end
  
  def convert_to_jpg
    puts 'converting to jpg...'
    manipulate!(:format => 'jpg')
  end
  
end