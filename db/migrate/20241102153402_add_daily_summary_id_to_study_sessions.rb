class AddDailySummaryIdToStudySessions < ActiveRecord::Migration[6.1]
  def change
    add_reference :study_sessions, :daily_summary, null: false, foreign_key: true
  end
end
