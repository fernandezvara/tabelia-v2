# encoding: utf-8
class OriginalUploader < CarrierWave::Uploader::Base

  storage :file


  version :scaled do
    process :resize_to_fit => [730, 730]
    process :quality => 70
  end

  def store_dir
    "/opt/private/original/#{model.id}"
  end

  def extension_white_list
    %w(jpg jpeg)
  end
end