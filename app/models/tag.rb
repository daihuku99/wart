class Tag < ApplicationRecord
  has_many :art_tags, dependent: :destroy
end
