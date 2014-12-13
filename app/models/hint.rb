class Hint < ActiveRecord::Base
  belongs_to :group
  belongs_to :user

  validates_presence_of :user, :group
end
