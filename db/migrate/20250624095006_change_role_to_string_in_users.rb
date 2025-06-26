class ChangeRoleToStringInUsers < ActiveRecord::Migration[6.1] # or your Rails version
  def change
    change_column :users, :role, :string
  end
end
