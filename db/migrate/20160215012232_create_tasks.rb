class CreateTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks do |t|
      t.string :name
      t.references :client, foreign_key: true
      t.references :project, foreign_key: true
      t.text :notes
      t.date :start_at
      t.date :end_at
      t.integer :effort_per_day_in_hours, default: 8

      t.timestamps
    end
  end
end
