class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.integer :id_user
      t.string :contenido
      t.string :foto
      t.datetime :fecha_hora

      t.timestamps
    end
  end
end
