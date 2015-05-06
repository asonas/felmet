class Event < ActiveRecord::Base
  belongs_to :user
  belongs_to :felica
  belongs_to :location

  after_create do
    self.touch(:checkin_at)
    UserMailer.checkin(self).deliver
  end

  after_initialize :calculate_enrollment_time

  attr_accessor :hours, :minutes

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

  def calculate_enrollment_time
    return nil if new_record?
    return nil if open?
    days = (checkout_at - checkin_at).divmod(24*60*60)
    @hours = days[1].divmod(60*60)
    @minutes = hours[1].divmod(60)
  end

  def enrollment_time
    return "在籍中です" if open?
    "#{@hours[0].to_i}時間 #{@minutes[0].to_i}分"
  end

  def checkout!
    return if close?

    self.touch(:checkout_at)
    save
    UserMailer.checkout(self).deliver
  end

  def open?
    checkin_at.present? && checkout_at.nil?
  end

  def close?
    checkin_at.present? && checkout_at.present?
  end

end
