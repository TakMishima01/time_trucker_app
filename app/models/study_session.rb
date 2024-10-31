class StudySession < ApplicationRecord
  belongs_to :user
  belongs_to :daily_summary
end
