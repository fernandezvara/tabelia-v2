# encoding: utf-8
class OriginalUploader < CarrierWave::Uploader::Base

  storage :file

  def store_dir
    "/original/#{model.id}"
  end

  def extension_white_list
    %w(jpg jpeg png)
  end
end