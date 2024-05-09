class Message < ApplicationRecord
# アソシエーション
has_many :users
belongs_to :room
end
