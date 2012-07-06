class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.integer :owner_id
      t.integer :requester_id
      t.datetime :start_at
      t.datetime :end_at

      t.timestamps
    end
  end
end
