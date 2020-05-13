class Event < ApplicationRecord
  belongs_to :user

  enum event_type: {
    プライベート: 0,
    イラスト投稿日: 1,
    展覧会: 2
  }
end
