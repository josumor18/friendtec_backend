class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :carnet
      t.string :nombre
      t.string :email
      t.string :password
      t.string :auth_token
      t.string :foto

      t.timestamps
    end
  end
end
