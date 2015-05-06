class Event < ActiveRecord::Base
  belongs_to :user
  belongs_to :felica
  belongs_to :location

  after_create do
    self.touch(:checkin_at)
    UserMailer.checkin(self).deliver
  end

  scope :fetch_at, ->(date) { where(checkin_at: date.at_beginning_of_month..date.at_end_of_month) }

  def enrollment_time
    return "在籍中です" if open?
    days = (checkout_at - checkin_at).divmod(24*60*60)
    hours = days[1].divmod(60*60)
    minutes = hours[1].divmod(60)
    "#{hours[0].to_i}時間 #{minutes[0].to_i}分"
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
