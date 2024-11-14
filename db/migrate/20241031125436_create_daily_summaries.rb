class CreateDailySummaries < ActiveRecord::Migration[6.1]
  def change
    create_table :daily_summaries do |t|
      t.references :user, null: false, foreign_key: true
      t.date :date
      t.integer :total_actual_time
      
      t.timestamps
    end
  end
end
