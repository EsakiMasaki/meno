class Customer < ApplicationRecord
  # アソシエーション
  has_many :notes ,dependent: :destroy
  has_many :note_procedures ,dependent: :destroy
  has_many :note_comments ,dependent: :destroy
  has_many :categories ,dependent: :destroy
  has_many :favorites , dependent: :destroy
  has_many :favorited_customers , through: :favorites , source: :note

  has_many :relationships , class_name: "Relationship" , foreign_key: "follower_id" , dependent: :destroy
  has_many :reverse_of_relationships , class_name: "Relationship" , foreign_key: "followed_id" , dependent: :destroy
  has_many :followings , through: :relationships , source: :followed
  has_many :followers , through: :reverse_of_relationships , source: :follower

  # バリデーション
  validates :name, presence: true, length: {maximum: 15}

  # 顧客検索(部分一致)
  def self.looks(word)
    Customer.where("name LIKE?", "%#{word}%")
  end

  # フォロー中であるかの確認
  def followings?(customer)
    followings.include?(customer)
  end

  # プロフィール画像(サイズ指定)
  has_one_attached :profile_image

  def get_profile_image(width,height)
    unless profile_image.attached?
      file_path = Rails.root.join("app/assets/images/default-image.jpg")
      profile_image.attach(io: File.open(file_path),filename: "default-image.jpg")
    end
    profile_image.variant(resize_to_limit: [width,height])
  end

  # ゲストログイン
  def self.guest
    find_or_create_by!(name: 'ゲスト' ,email: 'guest@gmail.com') do |customer|
      customer.password = SecureRandom.urlsafe_base64
      customer.name = "ゲスト"
    end
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
