class Art < ApplicationRecord
  belongs_to :user
  has_many :exhibition_arts, dependent: :destroy
  has_many :cart_arts, dependent: :destroy
  has_many :art_tags, dependent: :destroy
  has_many :tags, through: :art_tags
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  attachment :image
end
