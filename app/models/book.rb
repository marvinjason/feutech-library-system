class Book < ApplicationRecord
  belongs_to :publisher

  mount_uploader :cover, AvatarUploader
end
