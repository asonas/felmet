class Felica < ActiveRecord::Base
  validates :idm, presence: true, uniqueness: true
end
