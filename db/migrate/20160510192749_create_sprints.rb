class CreateSprints < ActiveRecord::Migration
  def change
    create_table :sprints do |t|
      t.date :begin_date
      t.date :end_date
      t.references :project, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
