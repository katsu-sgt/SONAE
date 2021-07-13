class Post < ApplicationRecord
  attachment :post_image

  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user
  has_many :bookmarks, dependent: :destroy
  has_many :bookmarked_users, through: :bookmarks, source: :user
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags

# タグ作成
  def save_tags(savepost_tags)
    current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
    old_tags = current_tags - savepost_tags
    new_tags = savepost_tags - current_tags
    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(tag_name: old_name)
    end

    new_tags.each do |new_name|
      post_tag = Tag.find_or_create_by(tag_name: new_name)
      self.tags << post_tag
    end
  end
  
  # いいねしているか判断
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
  # ブックマークしているか判断
  def bookmarked?(user)
    bookmarks.where(user_id: user.id).exists?
  end
end
