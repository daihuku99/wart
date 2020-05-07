class Exhibition < ApplicationRecord
  belongs_to :user
  has_many :exhibition_arts, dependent: :destroy
end
