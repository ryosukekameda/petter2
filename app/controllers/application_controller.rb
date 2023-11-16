class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :search
  
  def search
    @q = Post.ransack(params[:q])
    @post = @q.result(distinct: true)
    @result = params[:q]&.values&.reject(&blank?)
  end

  protected
  
  def after_sign_in_path_for(resource)
    case resource
    when Admin
      admin_path
    when User
      root_path
    else
      super # Deviseのデフォルトの挙動を呼び出す
    end
  end
  
  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :admin
      new_admin_session_path
    elsif resource_or_scope == :user
      new_user_session_path
    else
      root_path # または他のデフォルトのパス
    end
  end

  
  def guest_sign_in
    user = User.guest
    sign_in user
    flash[:notice] = "ゲストユーザーとしてログインしました。"
    redirect_to root_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :nickname, :phone_number, :is_deleted, :is_user_status, :encrypted_password])
  end
end
