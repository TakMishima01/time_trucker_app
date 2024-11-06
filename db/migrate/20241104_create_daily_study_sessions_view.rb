class CreateDailyStudySessionsView < ActiveRecord::Migration[6.1]
  def up
    execute <<-SQL
      CREATE VIEW daily_study_sessions AS
      SELECT
        ds.id AS daily_summary_id,
        ds.user_id,
        ds.date,
        ds.total_actual_time,
        IFNULL(MAX(CASE WHEN s.row_num = 1 THEN s.start_time END), '') AS start_time1,
        IFNULL(MAX(CASE WHEN s.row_num = 1 THEN s.end_time END), '') AS end_time1,
        IFNULL(MAX(CASE WHEN s.row_num = 2 THEN s.start_time END), '') AS start_time2,
        IFNULL(MAX(CASE WHEN s.row_num = 2 THEN s.end_time END), '') AS end_time2,
        IFNULL(MAX(CASE WHEN s.row_num = 3 THEN s.start_time END), '') AS start_time3,
        IFNULL(MAX(CASE WHEN s.row_num = 3 THEN s.end_time END), '') AS end_time3
      FROM daily_summaries ds
      LEFT JOIN (
        SELECT
          *,
          ROW_NUMBER() OVER(PARTITION BY daily_summary_id ORDER BY start_time ASC) AS row_num
        FROM study_sessions
      ) s ON ds.id = s.daily_summary_id
      GROUP BY ds.id, ds.user_id, ds.total_actual_time
    SQL
  end

  def down
    execute <<-SQL
      DROP VIEW daily_study_sessions
    SQL
  end
end
