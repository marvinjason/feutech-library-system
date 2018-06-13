class Book < ApplicationRecord
  belongs_to :publisher
  has_many :authorships, dependent: :destroy
  has_many :authors, through: :authorships
  has_many :reservations, dependent: :destroy
  has_many :users, through: :reservations
  has_many :reviews, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :logs, as: :logable, dependent: :destroy

  mount_uploader :cover, AvatarUploader

  def author
    authors = self.authors.map { |a| "#{a.first_name} #{a.last_name}" }
    authors.join(', ')
  end
end
