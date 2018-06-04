class Author < ApplicationRecord
  mount_uploader :avatar, AvatarUploader
end
