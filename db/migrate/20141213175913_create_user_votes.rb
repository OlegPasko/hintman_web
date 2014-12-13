class CreateUserVotes < ActiveRecord::Migration
  def change
    create_table :user_votes do |t|
      t.belongs_to :user, index: true
      t.belongs_to :hint, index: true
      t.boolean :positive

      t.timestamps null: false
    end
    add_foreign_key :user_votes, :users
    add_foreign_key :user_votes, :hints
  end
end
