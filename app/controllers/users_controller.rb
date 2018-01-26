class UsersController < ApplicationController
  before_action :logged_in_user, only: %i(index edit update)
  before_action :correct_user, only: %i(edit update destroy show)
  before_action :admin_user, only: %i(destroy)

  def index
    @users = User.all.paginate(page: params[:page], per_page: Settings.user.per_page.size)
  end

  def show
    if @user
      render :show
    else
      render "static_pages/home"
    end
  end

  def destroy
    @user.destroy
    flash[:success] = t("controllers.users.user_destroy")
    redirect_to users_url
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = t("controllers.users.please_check_email")
      redirect_to root_url
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = t("controllers.users.change_password_success")
      redirect_to @user
    else
      render :edit
    end
  end

  private

  def admin_user
    return if current_user.admin?
    flash.now[:danger] = t("controllers.users.you_not_admin")
  end

  def correct_user
    @user = User.find_by(id: params[:id])
    if @user
      @user
    elsif @user.nil?
      flash.now[:danger] = t("controllers.users.not_found_user")
    else
      redirect_to root_url
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :password,
      :password_confirmation)
  end

  def logged_in_user
    return if logged_in?
    flash[:danger] = t("controllers.users.please_login")
    redirect_to login_url
  end
end
