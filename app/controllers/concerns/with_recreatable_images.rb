module Concerns
  module WithRecreatableImages
    extend ActiveSupport::Concern

    included do
      attr_accessor :image_resize_strategies
    end

    def recreate_image!(image, version:, with_strategy:)
      self.image_resize_strategies = { version => with_strategy }
      self.public_send(image).recreate_versions!(version)
      self.save
    end

  end
end
