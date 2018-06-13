class Log < ApplicationRecord
  belongs_to :logable, polymorphic: true
  belongs_to :user

  validates :log_type, presence: true
end
