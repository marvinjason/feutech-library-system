class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :book
  belongs_to :comment,
    class_name: 'Comment',
    foreign_key: 'comment_id',
    optional: true
  has_many :comments
end
