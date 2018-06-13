class Review < ApplicationRecord
  belongs_to :book
  belongs_to :user
  has_many :logs, as: :logable, dependent: :destroy

  validates :body, :rating, presence: true
end
