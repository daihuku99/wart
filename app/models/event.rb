class Event < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, length: {maximum: 10}
  validates :detail, presence: true, length: {maximum: 20}
  # validate :start_date_check
  validate :end_date_check

  # def start_date_check
  #   errors.add(:start_date, "は今日以降のものを選択してください") if start_date < Date.today
  # end

  def end_date_check
   errors.add(:end_date, "は開始日以降のものを選択してください") if end_date < start_date
  end

  enum event_type: {
    プライベート: 0,
    イラスト投稿日: 1,
    展覧会: 2
  }
end
