# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  before_action :ensure_normal_user, only: [:destroy]
  # before_action :configure_sign_in_params, only: [:create]
  before_action :reject_user, only: [:create]
  
  def after_sign_in_path_for(resource)
    root_path
  end
  
  def guest_sign_in
    guest_user = User.find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲスト"
      user.nickname = "げすと"
      user.phone_number = "00000000000"
      user.is_deleted = false
    end
    sign_in guest_user
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  
  protected
  
  def ensure_normal_user
    if resource && resource.email == 'guest@example.com'
      flash.now[:notice] = "ゲストユーザーの削除はできません。"
      redirect_to root_path
    end
  end
  
  def reject_user
    @user = User.find_by(email: params[:user][:email])
    if @user
      if @user.valid_password?(params[:user][:encrypted_password]) && (@user.is_deleted == true)
        flash[:notice] = "退会済みです。再度ご登録ください"
        redirect_to new_user_registration_path
      else
        flash[:notice] = "項目を入力してください"
      end
    else
      flash[:notice] = "該当ユーザーが見つかりません"
    end
  end
  
end
