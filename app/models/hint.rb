class Hint < ActiveRecord::Base
  belongs_to :group
  belongs_to :user
  has_many :user_votes

  validates_presence_of :user, :group
end
