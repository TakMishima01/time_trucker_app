class ApplicationController < ActionController::Base
  # ログインしていなければログイン画面に遷移させる
  before_action :authenticate_user!
  # sign_upのときにnameも登録するように変更する
  before_action :configure_permitted_parameters, if: :devise_controller?

  # ログイン後に遷移するパスを設定
  #
  # @param [Resource] resource ログインしたリソース（通常はUser）
  # @return [String] 遷移先のパス
  def after_sign_in_path_for(resource)
    root_path
  end

  # サインアウト後に遷移するパスを設定
  #
  # @param [Resource] resource ログインしたリソース（通常はUser）
  # @return [String] 遷移先のパス
  def after_sign_out_path_for(resource)
    new_user_session_path
  end

  protected

  # Deviseで許可するパラメータを設定
  #
  # @return [void]
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
