class Felica < ActiveRecord::Base
  validates :idm, presence: true, uniqueness: true

  scope :active, -> { where(activation: true) }
  scope :not_active, -> { where(activation: false) }

  has_one :user
  has_many :events

  def activate!
    return if activate?
    self.activation = true
    self.touch(:activated_at)
    save!
  end

  def activate?
    self.activation
  end

  def fetch_active_event
    event = self.events.last
    return nil if event.nil?
    return nil if event.close?

    event
  end
end
