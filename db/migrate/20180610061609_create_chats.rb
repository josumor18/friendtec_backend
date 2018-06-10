class CreateChats < ActiveRecord::Migration[5.0]
  def change
    create_table :chats do |t|
      t.integer :id_user
      t.integer :id_friend
      t.string :last_message
      t.boolean :visto

      t.timestamps
    end
  end
end
