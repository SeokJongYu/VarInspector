class CreateAnalyses < ActiveRecord::Migration[5.1]
  def change
    create_table :analyses do |t|
      t.string :name
      t.text :description
      t.string :seq_blood1_data
      t.string :seq_blood2_data
      t.string :seq_brain1_data
      t.string :seq_brain2_data
      t.string :job_id
      t.string :status
      t.string :result_dir
      t.references :project, foreign_key: true

      t.timestamps
    end
  end
end
