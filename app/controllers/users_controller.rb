class UsersController < ApplicationController
  def show
    @user = User.find_by(id: params[:id])
    if @user
      render :show
    else
      flash.now[:danger] = t("controllers.users.not_found_user")
      render "static_pages/home"
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = t("controllers.users.welcome_to_app")
      redirect_to @user
    else
      render :new
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :password,
      :password_confirmation)
  end
end
