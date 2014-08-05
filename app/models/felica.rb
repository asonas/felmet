class Felica < ActiveRecord::Base
  validates :idm, presence: true, uniqueness: true

  scope :active, -> { where(activation: true) }

  has_one :user

  def activate!
    return if activate?
    self.activation = true
    self.touch(:activated_at)
    save!
  end

  def activate?
    self.activation
  end
end
