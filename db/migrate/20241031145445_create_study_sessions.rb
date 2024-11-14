class CreateStudySessions < ActiveRecord::Migration[6.1]
  def change
    create_table :study_sessions do |t|
      t.references :user, null: false, foreign_key: true
      t.datetime :start_time
      t.datetime :end_time
      t.integer :actual_time

      t.timestamps
    end
  end
end
