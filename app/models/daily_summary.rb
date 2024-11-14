class DailySummary < ApplicationRecord
  belongs_to :user
  has_many :study_sessions, dependent: :destroy
  has_many :daily_study_sessions
  accepts_nested_attributes_for :study_sessions, allow_destroy: true

  # study_sessionのレコードが更新されたらtotal_actual_timeの値を更新する
  #
  # @param [id] daily_summary_id
  def update_total_actual_time(id)
    study_sessions = self.study_sessions.where(daily_summary_id: id)
    total_actual_time = 0
    study_sessions.each do |session|
      total_actual_time += session.actual_time
    end
    update(total_actual_time: total_actual_time)
  end
end
