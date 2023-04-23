#  Pass word rests controller
class PasswordResetsController < ApplicationController
  before_action :set_user, only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def new; end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = "Email sent with password reset instructions"
      redirect_to root_url
    else
      flash.now[:danger] = "Email address not found"
      render 'new'
    end
  end

  def edit; end

  def update
    if params[:user][:password].empty?
      handle_empty_password
    elsif @user.update(user_params)
      handle_successful_update
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  # beforeフィルタ
  # get_userはエラーになった
  def user
    @user = User.find_by(email: params[:email])
  end

  # 有効なユーザーかどうか確認する
  def valid_user
    unless @user&.activated? &&
           @user&.authenticated?(:reset, params[:id])
      redirect_to root_url
    end
  end

  # トークンが期限切れかどうか確認する
  def check_expiration
    return unless @user.password_reset_expired?

    flash[:danger] = "Password reset has expired."
    redirect_to new_password_reset_url
  end

  def set_user
    @user = User.find_by(email: params[:email])
  end

  def handle_empty_password
    @user.errors.add(:password, :blank)
    render 'edit'
  end

  def handle_successful_update
    log_in @user
    @user.update(reset_digest: nil)
    flash[:success] = "Password has been reset."
    redirect_to @user
  end
end
