# encoding: utf-8

class IdentifyingImageUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  include CarrierWave::MiniMagick
  include CarrierWave::MimeTypes

  # Choose what kind of storage to use for this uploader:
  # storage :file
  storage :fog

  process :set_content_type

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :web_thumb do
    process :resize_to_fit => [150, 150]
  end
  version :web_preview do
    process :resize_to_fit => [400, 400]
  end
  version :print_preview do
    process :resize_to_fit => [256, 256]
  end
  version :web_full do
    process :resize_to_fit => [1024, 768]
  end
  version :print_full do
    process :resize_to_fit => [2048, 2048]
  end

end
