class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true
  before_save { self.email = email.downcase }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, {presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }}
  
  has_many :todos, dependent: :destroy
  attachment :profile_image
  
  # フォローする側から中間テーブルへのアソシエーション
  has_many :relationships, foreign_key: :following_id
  # フォローする側からフォローされたユーザを取得する
  has_many :followings, through: :relationships, source: :follower

  # フォローされる側から中間テーブルへのアソシエーション
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: :follower_id
  # フォローされる側からフォローしているユーザを取得する
  has_many :followers, through: :reverse_of_relationships, source: :following

  # ユーザーがあるユーザーにフォローされているかどうかを判定するメソッド
  # 引数のuserにフォローされているかどうかを判定。
  def is_followed_by?(user)
    # あるユーザーが引数に渡されたユーザーに、フォローされているかどうか判定
    reverse_of_relationships.find_by(following_id: user.id).present?
  end

  # Gemfileにbcryptを追加した
  has_secure_password

end
