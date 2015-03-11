class RemovePasswordFromUsers < ActiveRecord::Migration
  def up
  	remove_column :users, :RemovePassword
  end

  def down
  	add_column :users, :password, :string
  end
end
