class Author < ApplicationRecord
  has_many :authorships
  has_many :books, through: :authorships

  mount_uploader :avatar, AvatarUploader
end
