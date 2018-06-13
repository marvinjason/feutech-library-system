class Reservation < ApplicationRecord
  belongs_to :book
  belongs_to :user
  has_many :logs, as: :logable, dependent: :destroy

  validates :start, :end, :status, presence: true
end
