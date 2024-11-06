class DailySummary < ApplicationRecord
  belongs_to :user
  has_many :study_sessions
  has_many :daily_study_sessions
end
