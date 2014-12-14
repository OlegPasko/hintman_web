class Hint < ActiveRecord::Base
  belongs_to :group
  belongs_to :user
  has_many :user_votes, dependent: :destroy

  validates_presence_of :user, :group, :content

  validates_length_of :content, maximum: 500

  scope :active, -> { where('created_at > ?', Time.now-1.day) }

end
