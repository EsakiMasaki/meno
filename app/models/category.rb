class Category < ApplicationRecord
  # アソシエーション
  has_many :notes
  belongs_to :customer

  # バリデーション
  validates :name, presence: true

  # カテゴリー検索(部分一致)
  def self.looks(word)
    Category.where("name LIKE?", "%#{word}%")
  end
end
