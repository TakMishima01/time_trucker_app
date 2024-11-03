class ChangeTotalActualTimeToDecimalInDailySummaries < ActiveRecord::Migration[6.1]
  def change
    change_column :daily_summaries, :total_actual_time, :decimal, precision: 6, scale: 2
  end
end
