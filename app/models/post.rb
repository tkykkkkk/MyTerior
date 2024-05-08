class Post < ApplicationRecord
#   アソシエーションゾーン
belongs_to :user
  has_one_attached :image
end
