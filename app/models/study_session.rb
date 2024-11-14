class StudySession < ApplicationRecord
  belongs_to :user
  belongs_to :daily_summary

  # 開始時間をHH:mm形式に変換
  def formatted_start_time
    start_time.strftime("%H:%M") if start_time.present?
  end

  # 終了時間をHH:mm形式に変換
  def formatted_end_time
    end_time.strftime("%H:%M") if end_time.present?
  end

  # view表示用にフォーマットされた時間を返す
  def formatted_times
    {
      start_time: formatted_start_time,
      end_time: formatted_end_time
    }
  end

  private

  # start_timeとend_timeを再構築する
  def rebuild_times
    self.start_time = Time.current.chenge(hour: start_time_hour.to_i, minute: start_time_minute.to_i) if start_time_hour.present? && start_time_minute.present?
    return unless end_time_hour.present? && end_time_minute.present?

    self.end_time = Time.current.chenge(hour: end_time_hour.to_i, minute: end_time_minute.to_i)
  end
end
