class UserVote < ActiveRecord::Base
  belongs_to :user
  belongs_to :hint

  validates_uniqueness_of :hint_id, scope: :user_id
  validates_presence_of :hint_id, :user_id

  VALUES = %w(up down)
end