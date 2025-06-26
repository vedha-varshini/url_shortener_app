class CleanupDeviseFieldsAndFixRoleColumn < ActiveRecord::Migration[7.0]
  def up
    remove_column :users, :encrypted_password, :string if column_exists?(:users, :encrypted_password)
    remove_column :users, :reset_password_token, :string if column_exists?(:users, :reset_password_token)
    remove_column :users, :reset_password_sent_at, :datetime if column_exists?(:users, :reset_password_sent_at)
    remove_column :users, :remember_created_at, :datetime if column_exists?(:users, :remember_created_at)

    # Convert string roles to integers before changing column type
    User.where(role: 'user').update_all(role: 0)
    User.where(role: 'admin').update_all(role: 1)

    change_column :users, :role, :integer, using: 'role::integer', default: 0
  end

  def down
    change_column :users, :role, :string
    User.where(role: 0).update_all(role: 'user')
    User.where(role: 1).update_all(role: 'admin')

    add_column :users, :encrypted_password, :string, default: '', null: false
    add_column :users, :reset_password_token, :string
    add_column :users, :reset_password_sent_at, :datetime
    add_column :users, :remember_created_at, :datetime
  end
end
