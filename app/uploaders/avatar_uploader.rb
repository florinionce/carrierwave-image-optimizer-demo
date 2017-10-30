class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::ImageOptimizer
  process :optimize
end
