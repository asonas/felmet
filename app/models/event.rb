class Event < ActiveRecord::Base
  belongs_to :user
  belongs_to :felica
  belongs_to :location

  after_create do
    self.touch(:checkin_at)
    UserMailer.checkin(self).deliver_now
  end

  after_initialize :calculate_enrollment_seccond

  attr_accessor :hours, :minutes, :seccond

  scope :fetch_at, ->(date) { where(checkin_at: date.at_beginning_of_month..date.at_end_of_month) }

  # TODO EventService? EventEntity?
  def self.sum_enrollment_time(events)
    hours = []
    minutes = []
    events.each do |event|
      next if event.open?
      hours.push event.hours[0]
      minutes.push event.minutes[0]
    end

    "#{hours.sum}時間 #{minutes.sum}分"
  end

  def calculate_enrollment_seccond
    return nil if new_record?
    return nil if open?
    @day, @seccond = (self.checkout_at - self.checkin_at).ceil.divmod(86400)
  end

  def enrollment_time
    return "在籍中です" if open?
    return "チェックアウトをしていません。" if self.uncheckouted?
    (Time.parse("1/1") + @seccond).strftime("%H時間%M分")
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
