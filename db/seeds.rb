require 'faker'

# Userの作成
user = User.create!( 
  name: "Test User", email: "test@test.com", password: "33333333", password_confirmation: "33333333" 
)

#9月の学習記録
daily_summaries = [] 
(1..30).each do |day|
  date = Date.new(2024, 9, day)
  daily_summary = user.daily_summaries.create!(date: date)
  daily_summaries << daily_summary
end
  
daily_summaries.each do |daily_summary|
  total_actual_time = 0.0
  rand(1..5).times do
    start_time = Faker::Time.between_dates(from: daily_summary.date, to: daily_summary.date, period: :day)
    actual_time = rand(15..120)
    end_time = start_time + actual_time.minutes
    
    user.study_sessions.create!(
      daily_summary_id: daily_summary.id,
      start_time: start_time,
      end_time: end_time,
      actual_time: actual_time
    )
    
    total_actual_time += actual_time
  end
  daily_summary.update!(total_actual_time: total_actual_time)
end

#10月の学習記録
daily_summaries = [] 
(1..31).each do |day|
  date = Date.new(2024, 10, day)
  daily_summary = user.daily_summaries.create!(date: date)
  daily_summaries << daily_summary
end
  
daily_summaries.each do |daily_summary|
  total_actual_time = 0.0
  rand(1..5).times do
    start_time = Faker::Time.between_dates(from: daily_summary.date, to: daily_summary.date, period: :day)
    actual_time = rand(15..120)
    end_time = start_time + actual_time.minutes
    
    user.study_sessions.create!(
      daily_summary_id: daily_summary.id,
      start_time: start_time,
      end_time: end_time,
      actual_time: actual_time
    )
    
    total_actual_time += actual_time
  end
  daily_summary.update!(total_actual_time: total_actual_time)
end