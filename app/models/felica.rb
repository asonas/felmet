class Felica < ActiveRecord::Base
  validates :idm, presence: true, uniqueness: true

  scope :active, -> { where(activation: true) }

  def activate!
    return unless activate?
    self.activation = true
    self.touch(:activated_at)
    save!
  end

  def activate?
    self.activation
  end
end
