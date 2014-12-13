class Group < ActiveRecord::Base
  has_many :hints, dependent: :destroy
end
