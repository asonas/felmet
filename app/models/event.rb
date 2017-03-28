class Event < ActiveRecord::Base
  belongs_to :user
  belongs_to :felica
  belongs_to :location

  after_create do
    UserMailer.checkin(self).deliver_now
  end

  after_initialize :calculate_enrollment_seccond
  scope :active, -> { where.not(checkout_at: nil) }

  attr_accessor :hours, :minutes, :second, :seconds

  scope :fetch_at, ->(date) { where(checkin_at: date.at_beginning_of_month..date.at_end_of_month) }

  # TODO EventService? EventEntity?
  def self.sum_enrollment_time(events)
    hours   = []
    minutes = []
    seconds = []
    # 時分秒の合計を出す
    events.active.each do |event|
      hour, second = (event.checkout_at - event.checkin_at).ceil.divmod(3600)
      minute, second = second.divmod(60)

      hours.push hour
      minutes.push minute
      seconds.push second
    end

    # 合計を出したあとさらにそれを分解する
    minute, second = seconds.sum.divmod(60)
    minutes.push minute
    hour, minute = minutes.sum.divmod(60)
    hours.push hour

    "#{hours.sum}時間#{minute}分"
  end

  def calculate_enrollment_seccond
    return nil if new_record?
    return nil if open?
    @day, @second = (self.checkout_at - self.checkin_at).ceil.divmod(86400)
  end

  def enrollment_time
    return "在籍中です" if open?
    return "チェックアウトをしていません。" if self.uncheckouted?
    (Time.parse("1/1") + @second).strftime("%H時間%M分")
  end

  def uncheckouted?
    @day >= 1
  end

  def checkout!
    return if close?

    self.touch(:checkout_at)
    save
    UserMailer.checkout(self).deliver_now
  end

  def open?
    checkin_at.present? && checkout_at.nil?
  end

  def close?
    checkin_at.present? && checkout_at.present?
  end

end
