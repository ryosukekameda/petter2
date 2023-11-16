class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲスト"
      user.nickname = "げすと"
      user.is_deleted = false
    end
  end
  
  has_many :posts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :followers, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followeds, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :following_users, through: :followers, source: :followed
  has_many :follower_users, through: :followeds, source: :follower
  
  has_one_attached :header_image
  has_one_attached :icon_image
  
  # 検索方法分岐
  def self.looks(search, word)
    if search == "perfect_match"
      @user = User.where("name LIKE?", "#{word}")
    elsif search == "forward_match"
      @user = User.where("name LIKE?","#{word}%")
    elsif search == "backward_match"
      @user = User.where("name LIKE?","%#{word}")
    elsif search == "partial_match"
      @user = User.where("name LIKE?","%#{word}%")
    else
      @user = User.all
    end
  end

  
  def get_header_image(width, height)
    unless header_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      header_image.attach(io: File.open(file_path), filename: 'no_image.jpg', content_type: 'image/jpeg')
    end
      header_image.variant(resize_to_limit: [width, height]).processed
  end
  
  def get_icon_image(width, height)
    unless icon_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      icon_image.attach(io: File.open(file_path), filename: 'no_image.jpg', content_type: 'image/jpeg')
    end
      icon_image.variant(resize_to_limit: [width, height]).processed
  end
  
  # 特定のユーザーがこのユーザーをフォローしているかどうかを確認
  def following?(other_user)
    self.following_users.include?(other_user)
  end
  
  # 他のユーザーをフォロー
  def follow(other_user_id)
    followers.create(followed_id: other_user_id)
  end

  # フォローを解除
  def unfollow(other_user_id)
    followers.find_by(followed_id: other_user_id).destroy
  end
end