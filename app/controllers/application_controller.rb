class ApplicationController < ActionController::Base
  before_action :authenticate_customer!, except: [:top,:about,:show,:search]
  before_action :permitted_parameters ,if: :devise_controller?

  def after_sign_in_path_for(resource)
    flash[:notice] = "ログインしました"
    root_path
  end

  def after_sign_out_path_for(resource)
    flash[:notice] = "ログアウトしました"
    root_path
  end

  def permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,keys: [:name,:profile_image])
  end
end
