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
    # "crop.jpg" if original_filename.present?
    "#{random_token}.jpg" if original_filename.present?
  end

  def random_token
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) or model.instance_variable_set(var, ActiveSupport::SecureRandom.hex(2))
  end
  
  version :cropped do
    process :process
  end
  
  version :cropped_thumb do
    process :process
    resize_to_limit(300,300)
  end
    
  def process
    puts "#{model.inspect}"
    puts "model"
    puts "x=#{model.x}, y=#{model.y}, w=#{model.w}, h=#{model.h}"
    manipulate! do |img|
      img.crop!(model.x.to_i, model.y.to_i, model.w.to_i, model.h.to_i)
    end
  end
  
end