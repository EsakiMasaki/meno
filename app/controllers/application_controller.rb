class ApplicationController < ActionController::Base
  before_action :permitted_parameters ,if: :devise_controller?

  # 管理者用ログインをしているかの確認
  def admin_match?
    unless admin_signed_in?
      redirect_to new_admin_session_path
    end
  end

  # 新規作成、ログイン時の遷移ページ
  def after_sign_in_path_for(resource)
    flash[:notice] = "ログインしました"
    root_path
  end

  # ログアウト時の遷移ページ
  def after_sign_out_path_for(resource)
    flash[:notice] = "ログアウトしました"
    new_customer_session_path
  end

  def permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,keys: [:name])
  end
end
