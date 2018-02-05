class CreateAnalyses < ActiveRecord::Migration[5.1]
  def change
    create_table :analyses do |t|
      t.string :name
      t.text :descriptioni
      t.text :seq_blood1
      t.text :seq_blood2
      t.text :seq_brain1
      t.text :seq_brain2
      t.references :project, foreign_key: true

      t.timestamps
    end
  end
end
