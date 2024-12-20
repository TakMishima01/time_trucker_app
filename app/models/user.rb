class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :daily_summaries
  has_many :daily_study_sessions, through: :daily_summaries
  has_many :study_sessions
end
