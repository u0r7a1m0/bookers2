class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  # サインイン後の遷移先パス設定
  def after_sign_in_path_for(resource)
     user_path(current_user.id)
  end
  
  # サインアウト後の遷移先パス設定
  def after_sign_out_path_for(resource)
    root_path
  end
  
  
  # 元からあったやつ
  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email])
  end
end
