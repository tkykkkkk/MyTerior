class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # アソシエーションゾーン
  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy, through: :posts
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  validates :name, presence: true, length: { maximum: 50 }
  validates :introduction, length: { maximum: 50 }
  
  has_one_attached :profile_photo
  
  def get_profile_photo
    (profile_photo.attached?) ?
    profile_photo: 'no_photo.jpg'
  end 
  
  # パスワード変更任意機能
  # def update_without_current_password(params, *options)
  #   if params[:password].blank? && params[:password_confirmation].blank?
  #     params.delete(:password)
  #     params.delete(:password_confirmation)
  #   end
    
  #   result = self.update(params, *options)
  #   clean_up_passwords
  #   result
  # end 
         
  GUEST_USER_EMAIL = "guest@example.com"

  def self.guest
    find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "guestuser"
    end
  end    

end
