class DailySummariesController < ApplicationController
    # 指定された年月の日付と学習セッションを取得 
    # 
    # @return [void] 
    #
  def index

    # 現在の今月と先月の合計学習時間を取得
    this_month = Time.current
    last_month = 1.month.ago
    this_month_sessions = current_user.daily_study_sessions.where('daily_study_sessions.date >= ? AND daily_study_sessions.date <= ?', this_month.beginning_of_month, this_month.end_of_month)
    last_month_sessions = current_user.daily_study_sessions.where('daily_study_sessions.date >= ? AND daily_study_sessions.date <= ?', last_month.beginning_of_month, last_month.end_of_month)
    @this_month_total_sessions = convert_minutes_to_hours(calc_total_time(this_month_sessions))
    @last_month_total_sessions = convert_minutes_to_hours(calc_total_time(last_month_sessions))

    if params[:year].present? && params[:month].present?
      @year = params[:year].to_i
      @month = params[:month].to_i
    else
      @year = this_month.year
      @month = this_month.month
    end

    # 表示する月の1日の日付を作成
    disp_day = Date.new(@year, @month, 1)
    # 表示する月の日付と曜日のマップを作成
    @daily_study_sessions_map = generate_date_map(disp_day.year, disp_day.month)
    # ユーザーの月間学習セッションを取得
    daily_study_sessions = if @year == this_month.year && @month == this_month.month
                              this_month_sessions
                          else 
                              current_user.daily_study_sessions.where('daily_study_sessions.date >= ? AND daily_study_sessions.date <= ?', disp_day.beginning_of_month, disp_day.end_of_month)
                          end

    # 前月と次月の計算
    @prev_year, @prev_month = @month ==  1 ? [@year - 1, 12] : [@year, @month - 1]
    @next_year, @next_month = @month == 12 ? [@year + 1, 1] : [@year, @month + 1]


    # マップとテーブルデータを結合
    @daily_study_sessions_map.each do |sessions_map|
      corresponding_sessions = daily_study_sessions.find { |session| session.date == sessions_map[:date] }

      if corresponding_sessions
        sessions_map.merge!(
          start_time1: corresponding_sessions.start_time1.present? ? DateTime.parse(corresponding_sessions.start_time1).strftime("%H:%M") : "",
          end_time1: corresponding_sessions.end_time1.present? ? DateTime.parse(corresponding_sessions.end_time1).strftime("%H:%M") : "",
          start_time2: corresponding_sessions.start_time2.present? ? DateTime.parse(corresponding_sessions.start_time2).strftime("%H:%M") : "",
          end_time2: corresponding_sessions.end_time2.present? ? DateTime.parse(corresponding_sessions.end_time2).strftime("%H:%M") : "",
          start_time3: corresponding_sessions.start_time3.present? ? DateTime.parse(corresponding_sessions.start_time3).strftime("%H:%M") : "",
          end_time3: corresponding_sessions.end_time3.present? ? DateTime.parse(corresponding_sessions.end_time3).strftime("%H:%M") : "",
          total_actual_time: convert_minutes_to_hours(corresponding_sessions.total_actual_time),
          daily_summary_id: corresponding_sessions.daily_summary_id.present? ? corresponding_sessions.daily_summary_id : ""
        )
      else 
        sessions_map.merge!(
          start_time1: "",
          end_time1: "",
          start_time2: "",
          end_time2: "",
          start_time3: "",
          end_time3: "",
          total_actual_time: "",
          daily_summary_id: ""
        )
      end
    end
    # 日付の形式を変換
    @daily_study_sessions_map.each do |entry|
      entry[:date] = entry[:date].strftime("%m/%d")
    end
  end

  def edit
  end

  def create
  end

  def update
  end
  
  private

  # 指定された年月の日付と曜日の配列を作る
  #
  # @param [Integer] year 年 (例: 2024)
  # @param [Integer] month 月 (例: 10)
  # @return [Array<Hash>] 日付と曜日の配列。各要素は以下の形式のハッシュ: 
  # {
  #   date: "yyyy-MM-dd"
  #   day_of_week: "漢字"  # 曜日を漢字1文字で表現 (例: 月, 火, 水...)
  # }
  #
  def generate_date_map(year, month)
    start_date = Date.new(year, month, 1)
    end_date = start_date.end_of_month

    date_map = (start_date..end_date).map do |date|
      {
        date: date,
        day_of_week: DAY_OF_WEEK_MAP[date.strftime("%A")]
      }
    end

    date_map
  end

  # 分単位を時間単位に変換
  #
  # @param [Float] 分
  # @return [Float] 時間
  def convert_minutes_to_hours(minutes)
    return 0.0 if minutes.nil?

    (minutes/60).round(1)
  end

  # 1ヶ月間のトータル学習時間を算出
  #
  # @param [daily_study_sessions] 学習時間view
  # @retun [Integer] 1ヶ月の合計学習時間
  def calc_total_time(sessions)
    total_time = 0
    sessions.each do |session|
      total_time += session.total_actual_time
    end
    total_time
  end
  
end
