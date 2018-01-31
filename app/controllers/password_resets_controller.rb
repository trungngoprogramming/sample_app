class PasswordResetsController < ApplicationController
  before_action :load_user, only: %i(edit update)
  before_action :check_expiration, only: %i(edit update)
  before_action :_get_user, only: %i(edit update)
  before_action :valid_user, only: %i(edit update)

  def new; end

  def create
    @user = User.find_by email: params[:password_reset][:email].downcase
    if @user
      @user.create_reset_digest
      @user.sent_password_reset_email
      flash[:info] = t "controllers.user.email.sent_with_password_reset"
      redirect_to root_url
    else
      flash[:danger] = t "contollers.user.email.address_not_found"
      render :new
    end
  end

  def edit; end

  def update
    if params[:user][:password].empty?
      update_empty
    elsif @user.update_attributes(user_params) && @user.update_attributes(reset_digest: nil)
      log_in @user
      flash[:success] = t "controllers.user.password_has_been_reset"
      redirect_to @user
    else
      not_change_password
    end
  end

  private

  def not_change_password
    render :edit
    flash[:danger] = t "controllers.user.password_has_not_reset"
  end

  def user_params
    params.require(:user).permit :password, :password_confirmation
  end

  def update_empty
    @user.error.add(:password, t("controllers.user.cant_be_empty"))
    render :edit
  end

  def check_expiration
    return unless @user.password_reset_expired?
    flash[:danger] = t "controllers.user.password_reset_has_expred"
    redirect_to new_password_reset_url
  end

  def load_user
    @user = User.find_by email: params[:email]
    return if @user
    flash[:danger] = t "controllers.user.not_found_user"
    render :new
  end
end
