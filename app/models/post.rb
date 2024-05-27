class Post < ApplicationRecord
  # アソシエーションゾーン
  has_many :post_comments, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :favorites, dependent: :destroy
  belongs_to :user
  has_many :photos, dependent: :destroy
  belongs_to :genre

  accepts_nested_attributes_for :photos
  validates :caption, presence: true
  validate :must_have_at_least_one_photo

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def self.looks(search, word)
    Post.where("caption LIKE ?", "%#{word}%")
  end

  private

  def must_have_at_least_one_photo
    error_message = I18n.locale == :ja ? "は１枚以上画像を入れてください" : 'must have at least one photo'
    errors.add(:photos, error_message) if photos.blank?
  end
end

