class Favorite < ApplicationRecord
  # アソシエーション
  belongs_to :customer
  belongs_to :note
end
