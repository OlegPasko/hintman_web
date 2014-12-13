class AddDeviceIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :device_id, :string
    add_column :users, :auth_token, :string
  end
end