class User < ApplicationRecord
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # アソシエーションゾーン
  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :rooms, through: :entries, dependent: :destroy
  # フォローしている関連付け
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  # フォローされている関連付け
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # フォローしているユーザーを取得
  has_many :followings, through: :active_relationships, source: :followed
  # フォロワーを取得
  has_many :followers, through: :passive_relationships, source: :follower
  # 指定したユーザーをフォローする
  def follow(user)
    active_relationships.create(followed_id: user.id)
  end 
  # 指定したユーザーのフォローを解除する
  def unfollow(user)
    active_relationships.find_by(followed_id: user.id).destroy
  end 
  # 指定したユーザーをフォローしているかどうかを判定
  def following?(user)
    followings.include?(user)
  end 
         
  validates :name, presence: true, length: { maximum: 50 }
  validates :introduction, length: { maximum: 50 }
  validates_acceptance_of :agreement, on: :create
  
  has_one_attached :profile_photo
  
  def get_profile_photo
    (profile_photo.attached?) ?
    profile_photo: 'no_photo.jpg'
  end 
  
  def active_for_authentication?
    super && (is_active == true)
  end
  
  def self.looks(search, word)
      User.where("name LIKE ?", "%#{word}%")
  end 
         
  GUEST_USER_EMAIL = "guest@example.com"

  def self.guest
    find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "guestuser"
    end
  end 
  
   def guest_user?
    email == GUEST_USER_EMAIL
   end

end
