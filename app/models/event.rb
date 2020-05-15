class Event < ApplicationRecord
  belongs_to :user

  validate :end_date_check
  # validate :start_date_before_today

  def end_date_check
    if self.end_date < self.start_date
      errors.add(:end_date, "終了日は開始日以降を選択してください。")
    end
  end

  # def start_date_before_today

  # end

  enum event_type: {
    プライベート: 0,
    イラスト投稿日: 1,
    展覧会: 2
  }
end
