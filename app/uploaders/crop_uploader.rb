# encoding: utf-8
class CropUploader < CarrierWave::Uploader::Base

  include CarrierWave::RMagick

  # Choose what kind of storage to use for this uploader:
  # storage :file
  storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    # "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    "#{mounted_as}/#{model.id}"
  end
  
  def filename
    # "avatar.jpg" if original_filename
    "crop.#{file.extension}" if original_filename.present?
  end

  version :cropped do
     process :process
  end
  
  def process
    if model.x.present?
      manipulate! do |img|
        img.crop!(model.x.to_i, model.y.to_i, model.w.to_i, model.h.to_i)
      end
    end
  end
  
end