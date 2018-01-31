class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
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
    flash.now[:danger] = t "controllers.email.wrong_password"
    render :new
  end

  def valid_email_password user
    if user.activated?
      is_remember? user
    else
      message
    end
  end

  def message
    flash[:warning] = t "controllers.email.account_not_activated"
    redirect_to root_url
  end

  def is_remember? user
    log_in user
    if params[:session][:remember_me] == Settings.user.remember.true?
      remember user
    else
      forget user
    end
    redirect_to user
  end
end
