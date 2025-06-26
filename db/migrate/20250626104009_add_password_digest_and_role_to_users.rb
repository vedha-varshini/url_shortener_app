class AddPasswordDigestAndRoleToUsers < ActiveRecord::Migration[7.0]
  def change
    # Add password_digest if it doesn't already exist
    add_column :users, :password_digest, :string unless column_exists?(:users, :password_digest)

    # Only add role if it's not already there
    add_column :users, :role, :string unless column_exists?(:users, :role)
  end
end
