class AddRfotoToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :rfoto, :string
  end
end
