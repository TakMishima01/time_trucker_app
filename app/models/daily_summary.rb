class DailySummary < ApplicationRecord
  belongs_to :user
  has_many :study_sessions
end
