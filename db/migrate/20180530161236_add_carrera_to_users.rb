class AddCarreraToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :carrera, :string
  end
end
