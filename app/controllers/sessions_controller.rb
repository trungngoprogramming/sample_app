class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      valid_email_password user
    else
      invalid_email_password
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private

  def invalid_email_password
    flash.now[:danger] = t("controllers.users.wrong_email_password")
    render :new
  end

  def valid_email_password user
    log_in user
    redirect_to user
    params[:session][:remember_me] == "1" ? remember(user) : forget(user)
  end
end
