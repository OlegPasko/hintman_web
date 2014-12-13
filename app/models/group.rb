class Group < ActiveRecord::Base
  has_many :hints, dependent: :destroy

  def active_hints
    hints.active
  end

end
