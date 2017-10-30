class User < ApplicationRecord
  include Concerns::WithRecreatableImages
  mount_uploader :avatar, AvatarUploader
end