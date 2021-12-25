class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true
  validates :profile, length: {maximum: 80 }
  before_save { self.email = email.downcase }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, {presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }}
  
  # 新しくクラスメソッドを作成
  def self.guest
    find_or_create_by(email: 'guest@example.com') do |user|
      #ゲストユーザーを作成する場合に必要な情報を作成
      # ユーザーのパスワードをランダムにする
      user.password = SecureRandom.urlsafe_base64
      # ユーザーの名前をゲストユーザーにする
      user.name = 'ゲストユーザー'
    end
  end

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

  has_many :requests, dependent: :destroy
  # ユーザーがあるユーザーにフォローされているかどうかを判定するメソッド
  # 引数のuserにフォローされているかどうかを判定。
  def is_followed_by?(user)
    # あるユーザーが引数に渡されたユーザーに、フォローされているかどうか判定
    reverse_of_relationships.find_by(following_id: user.id).present?
  end

end
