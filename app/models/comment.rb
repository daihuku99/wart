class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :art

  validates :comment, presence: true, length: {maximum: 30}
end
