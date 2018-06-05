class Book < ApplicationRecord
  belongs_to :publisher
  has_many :authorships
  has_many :authors, through: :authorships
  has_many :reservations
  has_many :users, through: :reservations
  has_many :reviews

  mount_uploader :cover, AvatarUploader
end
