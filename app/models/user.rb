class User < ActiveRecord::Base
  belongs_to :felica
  belongs_to :group
  accepts_nested_attributes_for :group
end
