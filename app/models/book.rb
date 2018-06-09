class Book < ApplicationRecord
  belongs_to :publisher
  has_many :authorships
  has_many :authors, through: :authorships
  has_many :reservations
  has_many :users, through: :reservations
  has_many :reviews
  has_many :comments
  has_many :logs, as: :logable

  mount_uploader :cover, AvatarUploader

  def author
    authors = self.authors.map { |a| "#{a.first_name} #{a.last_name}" }
    authors.join(', ')
  end
end
