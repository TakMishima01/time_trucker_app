class ChangeActualTimeToDecimalInStudySessions < ActiveRecord::Migration[6.1]
  def change
    change_column :study_sessions, :actual_time, :decimal, precision: 6, scale: 2
  end
end
