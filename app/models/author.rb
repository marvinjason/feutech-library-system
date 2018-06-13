class Author < ApplicationRecord
  has_many :authorships, dependent: :destroy
  has_many :books, through: :authorships
  has_many :logs, as: :logable, dependent: :destroy

  mount_uploader :avatar, AvatarUploader
end
