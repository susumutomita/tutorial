# sessions
class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if valid_user?(user)
      if user.activated?
        handle_valid_user(user)
      else
        handle_unactivated_user
      end
    else
      handle_invalid_user
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private

  def valid_user?(user)
    user&.authenticate(params[:session][:password])
  end

  def handle_valid_user(user)
    log_in user
    remember_or_forget_user(user)
    redirect_back_or user
  end

  def handle_unactivated_user
    message  = "Account not activated. "
    message += "Check your email for the activation link."
    flash[:warning] = message
    redirect_to root_url
  end

  def handle_invalid_user
    flash.now[:danger] = 'Invalid email/password combination'
    render 'new'
  end

  def remember_or_forget_user(user)
    params[:session][:remember_me] == '1' ? remember(user) : forget(user)
  end
end
