class DailyStudySession < ApplicationRecord
  self.table_name = 'daily_study_sessions'

  belongs_to :user
  belongs_to :daily_summary
end
