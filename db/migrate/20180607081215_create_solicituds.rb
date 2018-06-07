class CreateSolicituds < ActiveRecord::Migration[5.0]
  def change
    create_table :solicituds do |t|
      t.integer :id_user1
      t.integer :id_user2

      t.timestamps
    end
  end
end
