class User < ActiveRecord::Base
  belongs_to :felica
  belongs_to :group
  has_many :events

  def internal?
    role == "internal"
  end
end
