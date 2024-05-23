class Post < ApplicationRecord
#   アソシエーションゾーン
has_many :post_comments, dependent: :destroy
has_many :post_tags, dependent: :destroy
has_many :favorites, dependent: :destroy
belongs_to :user
has_many :photos, dependent: :destroy

accepts_nested_attributes_for :photos
validates :caption, presence: true

def favorited_by?(user)
 favorites.exists?(user_id: user.id)
end 

end
