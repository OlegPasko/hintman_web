class CreateHints < ActiveRecord::Migration
  def change
    create_table :hints do |t|
      t.text :content
      t.belongs_to :group, index: true
      t.belongs_to :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :hints, :groups
    add_foreign_key :hints, :users
  end
end
