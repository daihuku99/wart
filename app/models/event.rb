class Event < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, length: {maximum: 10}
  validates :detail, presence: true, length: {maximum: 20}
  validate :end_date_check

  def end_date_check
   errors.add(:end_date, "は開始日以降のものを選択してください") if end_date < start_date
  end

  enum event_type: {
    プライベート: 0,
    イラスト投稿日: 1,
    展覧会: 2
  }
end
