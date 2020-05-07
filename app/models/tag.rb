class Tag < ApplicationRecord
  has_many :art_tags, dependent: :destroy
  has_many :arts, through: :art_tags
end
