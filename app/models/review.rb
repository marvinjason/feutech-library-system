class Review < ApplicationRecord
  belongs_to :book
  belongs_to :user
  has_many :logs, as: :logable, dependent: :destroy
end
