class NoteComment < ApplicationRecord
  # アソシエーション
  belongs_to :customer
  belongs_to :note

  # バリデーション
  validates :comment, presence: true

  # コメントかメモかを選べる
  enum post_status: {
    comment: 0,
    memo: 1
  }
end
