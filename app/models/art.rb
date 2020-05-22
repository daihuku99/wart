class Art < ApplicationRecord
  belongs_to :user
  has_many :exhibition_arts, dependent: :destroy
  has_many :cart_arts, dependent: :destroy
  has_many :art_tags, dependent: :destroy
  has_many :tags, through: :art_tags
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  attachment :image

  validates :title, presence: true, length: {maximum: 10}
  validates :detail, presence: true, length: {maximum: 20}
  validates :image, presence: true

  def liked_by?(user) #引数userがいいねをしているかどうか
    likes.where(user_id: user.id).exists?
  end
end
