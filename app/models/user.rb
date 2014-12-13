class User < ActiveRecord::Base
  belongs_to :group
  has_many :hints, dependent: :destroy
  has_many :user_votes, dependent: :destroy

  validates_presence_of :device_id, :group

  def generate_auth_token!
    self.auth_token = SecureRandom.urlsafe_base64
    save
  end
end
