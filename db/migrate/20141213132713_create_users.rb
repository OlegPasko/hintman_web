class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.belongs_to :group, index: true

      t.timestamps null: false
    end
    add_foreign_key :users, :groups
  end
end
