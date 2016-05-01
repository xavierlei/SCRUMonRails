class CreateRequirements < ActiveRecord::Migration
  def change
    create_table :requirements do |t|
      t.text :description
      t.references :project, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
