class Post < ApplicationRecord
#   アソシエーションゾーン
has_many :post_comments, dependent: :destroy
has_many :post_tags
has_many :favorites
belongs_to :user
has_many :photos, dependent: :destroy

accepts_nested_attributes_for :photos
validates :caption, presence: true

end
