class Author < ApplicationRecord
  has_many :authorships
  has_many :books, through: :authorships
  has_many :logs, as: :logable

  mount_uploader :avatar, AvatarUploader
end
