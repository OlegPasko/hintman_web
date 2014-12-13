class User < ActiveRecord::Base
  belongs_to :group
  has_many :hints
  has_many :user_votes
end
