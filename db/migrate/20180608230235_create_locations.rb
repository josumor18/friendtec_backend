class CreateLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :locations do |t|
      t.integer :id_user
      t.float :latitud
      t.float :longitud

      t.timestamps
    end
  end
end
