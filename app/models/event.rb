class Event < ActiveRecord::Base
  belongs_to :user
  belongs_to :felica

  after_create do
    self.touch(:checkin_at)
  end

  def checkout!
    return if close?

    self.touch(:checkout_at)
    save
  end

  def open?
    checkin_at.present? && checkout_at.nil?
  end

  def close?
    checkin_at.present? && checkout_at.present?
  end
end
