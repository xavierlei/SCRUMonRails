class AddEmailToRoles < ActiveRecord::Migration
  def change
    add_column :roles, :email, :string
    add_index :roles, :email
  end
end
