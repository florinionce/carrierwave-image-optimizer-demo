class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::ImageOptimizer
  include CarrierWave::MiniMagick

  BASE_OPERATIONS = [{ convert: :jpg }]

  process :optimize

  version :carousel_large do
    BASE_OPERATIONS.each{ |operation| send(:process, operation) }
    process resize_strategy: [:carousel_large, :resize_to_fit, [970, 546]]
    process quality: 80
    process :optimize
  end

  private

  def quality(percentage)
    # https://github.com/carrierwaveuploader/carrierwave/wiki/how-to%3A-specify-the-image-quality
    manipulate! do |img|
      img.quality(percentage.to_s)
      img = yield(img) if block_given?
      img
    end
  end

  def resize_strategy(current_version, defined_strategy, defined_values)
    resize_strategy, resize_value = model.image_resize_strategies.try(:[], current_version).presence || [defined_strategy, defined_values]
    self.send(resize_strategy, *resize_value)
  end
end
