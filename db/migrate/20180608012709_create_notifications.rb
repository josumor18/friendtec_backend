class CreateNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :notifications do |t|
      t.integer :id_user
      t.integer :id_friend
      t.integer :id_post
      t.boolean :visto

      t.timestamps
    end
  end
end
