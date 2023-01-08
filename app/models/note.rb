class Note < ApplicationRecord
  belongs_to :customer
  belongs_to :category ,optional: true
  has_many :note_procedures, dependent: :destroy
  has_many :note_comments ,dependent: :destroy
  has_many :favorites , dependent: :destroy
  has_many :favorited_customers , through: :favorites , source: :customer

  def self.looks(word)
    Note.where("title LIKE?", "%#{word}%")
  end

  def favorited_by?(customer)
    favorites.exists?(customer_id: customer.id)
  end

  validates :title ,presence: true
  validates :can ,presence: true
  validates :conclude ,presence: true

  accepts_nested_attributes_for :note_procedures, allow_destroy: true

  enum publish_status: {
    publish: 0,
    nonpublic: 1
  }

end
