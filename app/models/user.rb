class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum sex: { 未入力: 0, 男性: 1, 女性: 2 }
  attachment :image
  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  validates :sex, presence: true

  has_many :posts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_posts, through: :favorites, source: :post
  has_many :bookmarks, dependent: :destroy
  has_many :bookmarked_posts, through: :bookmarks, source: :post
  has_many :items, dependent: :destroy
  has_many :shelters, dependent: :destroy
  has_many :post_comments, dependent: :destroy

  # ゲストログイン機能のためのメソッド
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲスト"
      user.job = "会社員"
      user.profile = "ゲストです。防災対策の参考にします。"
    end
  end
end
