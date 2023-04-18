# app/controllers/account_activations_controller.rb
class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by(email: params[:email])
    if user_valid_for_activation?(user)
      user.activate
      log_in user
      flash[:success] = "Account activated!"
      redirect_to user
    else
      flash[:danger] = "Invalid activation link"
      redirect_to root_url
    end
  end

  private

  def user_valid_for_activation?(user)
    user && !user.activated? && user.authenticated?(:activation, params[:id])
  end

  def activate_user(user)
    user.update(activated: true, activated_at: Time.zone.now)
  end
end
