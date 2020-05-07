class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :arts, dependent: :destroy
  has_many :exhibitions, dependent: :destroy
  has_many :cart_arts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  attachment :profile_image

  enum user_status: {
    閲覧のみ: 0,
    投稿機能あり: 1
  }

  enum is_deleted: {
    退会済み: true,
    有効: false
  }
end
