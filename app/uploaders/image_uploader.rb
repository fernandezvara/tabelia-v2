# encoding: utf-8
class ImageUploader < CarrierWave::Uploader::Base

  include CarrierWave::RMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
    "/assets/fallback/art_" + [version_name, "default.jpg"].compact.join('_')
  end

  process :resize_to_fit => [730, 730]

  version :cart do
    process :resize_to_fit => [300,300]
  end

  version :thumb do
    process :resize_to_fill => [75, 75]
  end

  version :mini do
    process :resize_to_fill => [30, 30]
  end

  def extension_white_list
    %w(jpg jpeg)
  end
end