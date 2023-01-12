class Note < ApplicationRecord
  # アソシエーション
  belongs_to :customer
  belongs_to :category ,optional: true
  has_many :note_procedures, dependent: :destroy
  has_many :note_comments ,dependent: :destroy
  has_many :favorites , dependent: :destroy
  has_many :favorited_customers , through: :favorites , source: :customer

   # バリデーション
  validates :title ,presence: true
  validates :can ,presence: true
  validates :conclude ,presence: true

  # ノート検索(部分一致)
  def self.looks(word)
    Note.where("title LIKE?", "%#{word}%")
  end

  # いいねしているか確認
  def favorited_by?(customer)
    favorites.exists?(customer_id: customer.id)
  end

  # 親モデル保存時に、関連付いた子モデルも保存
  accepts_nested_attributes_for :note_procedures, allow_destroy: true

  # 公開ステータス
  enum publish_status: {
    publish: 0,
    nonpublic: 1
  }

end
