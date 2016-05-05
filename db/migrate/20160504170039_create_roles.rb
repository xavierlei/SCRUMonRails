class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :description
      t.references :user, index: true, foreign_key: true
      t.references :team, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
