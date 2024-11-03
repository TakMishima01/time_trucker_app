class StudySessionsController < ApplicationController
  # newアクション
  #
  # @return [void]
  def new
    #進行中フラグがTRUEかつstart_timeが最新の学習記録レコードを取得
    @latest_session = current_user.study_sessions.where(ongoing: true).order(start_time: :desc).first
    @ongoing_session = @latest_session.present?
  end

  # createアクション
  #
  # @return [void]
  def create
    #1日の中で初めて学習する場合daily_summareisのレコードを作成する
    #そうでなければidを取得する
    daily_summary_id = find_or_create_daily_summary(Time.current.to_date)
    #study_sessionsのレコードを作成する
    #進行中フラグをTRUEにする
    @study_session = current_user.study_sessions.create(start_time: Time.current, daily_summary_id: daily_summary_id, ongoing: true)
    redirect_to root_path
  end

  # updateアクション
  #
  # @param [Integer] id StudySession ID
  # @return [void]
  def update
    #study_sessionsテーブルからidで該当レコードを取得
    @study_session = current_user.study_sessions.find(params[:id])
    #該当レコードの更新
    @study_session.update(end_time: Time.current, actual_time: calculate_actual_time(@study_session.start_time, Time.current), ongoing: false)
    #合計実学習時間に結果を再加算する
    update_daily_summary(@study_session)
    redirect_to root_path
  end

  def destroy
  end

  private
  
  # 学習時間を算出
  #
  # @param [Time] start_time 開始時間
  # @param [Time] end_time 終了時間
  # @return [Float] 学習時間（分単位　）
  def calculate_actual_time(start_time, end_time)
    return 0.0 if start_time.nil? || end_time.nil?

    ((end_time - start_time) / 60).round(2)
  end

  # 学習開始時にdaily_summaryにcerrent_dateのレコードがあるか確認し、なければ新規作成する
  #
  # @param [Date] date 日付
  # @return [Integer] daily_summary ID
  def find_or_create_daily_summary(date)
    daily_summary = current_user.daily_summaries.find_or_create_by(date: date) do |summary|
      summary.total_actual_time = 0
    end
    daily_summary.id
  end

  # 学習記録終了時に合計実学習時間を再加算
  #
  # @param [StudySession] study_session 学習セッション
  # @return [void]
  def update_daily_summary(study_session)
    daily_summary = current_user.daily_summaries.find(study_session.daily_summary_id)
    daily_summary.update(total_actual_time: daily_summary.total_actual_time + study_session.actual_time)
  end
  
end
