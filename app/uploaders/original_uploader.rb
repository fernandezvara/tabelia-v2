# encoding: utf-8
class OriginalUploader < CarrierWave::Uploader::Base

  include CarrierWave::RMagick
  
  storage :file

  version :scaled do
    process :resize_to_fit => [730, 730]
    process :quality => 95
  end

  def filename
    "original.#{file.extension}" if original_filename.present?
  end

  def store_dir
    "/opt/private/original/#{model.id}"
  end

  def extension_white_list
    %w(jpg jpeg png tif tiff)
  end
  
end