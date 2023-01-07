class NoteComment < ApplicationRecord
  belongs_to :customer
  belongs_to :note

  validates :comment, presence: true

  enum post_status: {
    comment: 0,
    memo: 1
  }
end
