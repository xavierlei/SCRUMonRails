class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.references :team, index: true, foreign_key: true
      t.references :sprint, index: true, foreign_key: true
      t.references :requirement, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
