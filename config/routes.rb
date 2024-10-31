Rails.application.routes.draw do
  devise_for :users
  # ルートパスの設定
  root "study_sessions#new"

  resources :daily_summaries, only:[:index, :edit, :create, :update]

  resources :study_sessions, only: [:new, :create, :update, :destory]

end
