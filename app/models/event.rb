class Event < ActiveRecord::Base
  belongs_to :user
  belongs_to :felica
  belongs_to :location

  after_create do
    self.touch(:checkin_at)
    UserMailer.checkin(self).deliver
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
