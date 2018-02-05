class CreateAnalyses < ActiveRecord::Migration[5.1]
  def change
    create_table :analyses do |t|
      t.string :name
      t.text :description
      t.string :seq_blood1
      t.string :seq_blood2
      t.string :seq_brain1
      t.string :seq_brain2
      t.string :job_id
      t.string :status
      t.string :result_dir
      t.references :project, foreign_key: true

      t.timestamps
    end
  end
end
