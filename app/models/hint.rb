class Hint < ActiveRecord::Base
  belongs_to :group
  belongs_to :user
  has_many :user_votes, dependent: :destroy

  validates_presence_of :user, :group, :content

  validates_length_of :content, maximum: 500

  after_create :send_push

  scope :active, -> { where('created_at > ?', Time.now-1.day) }

  def send_push
    #TODO: temp method to show push deliveries and should be moved to scheduled rake with some selection
    push = Push.new('push')
    users = User.all.where(group_id: self.group.id)
    json_data = { data: { alert: self.content, hint_id: self.id } }.to_json

    users.each { |user| push.send(user.device_id, json_data) }

    # handle_asynchronously :send_push, TODO: delayed jobs
  end

end
