class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && !user.authenticated?(:activation, params[:id])
      user.activate
      log_in user
      redirect_to user
      flash[:success] = t "controllers.account_activations.account_activated"
    else
      flash[:danger] = t ".controllers.account_activations.invalid_activation_link"
    end
  end
end
