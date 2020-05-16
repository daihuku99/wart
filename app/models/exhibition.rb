class Exhibition < ApplicationRecord
  belongs_to :user
  has_many :exhibition_arts, dependent: :destroy

  validates :title, presence: true, length: {maximum: 20 }
  validates :detail, presence: true, length: {maximum: 50 }
  validate :start_date_check
  validate :end_date_check
  validate :date_count

  def start_date_check
    errors.add(:start_date, "は今日以降のものを選択してください") if start_date < DateTime.now.in_time_zone('Tokyo')
  end

  def end_date_check
   errors.add(:end_date, "は開始日以降のものを選択してください") if end_date < start_date
  end

  def date_count
    errors.add(:end_date, "開催期間は5日間以内に設定してください") if end_date - start_date > 432000
  end

  def new_exhibition(user, parameter)
    Exhibition.transaction do
      self.save!
      user.cart_arts.each do |cart_art|
        exhibition_art = self.exhibition_arts.new(art_id: cart_art.art.id)
        exhibition_art.save
      end
      event = user.events.new(parameter)
      event.event_type = 2
      event.exhibition_id = self.id
      event.save!
      user.cart_arts.destroy_all
    end
  end

end
