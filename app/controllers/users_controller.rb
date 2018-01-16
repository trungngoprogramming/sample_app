class UsersController < ApplicationController
  def show
    @user = User.find_by(id: params[:id])
    if @user
      render :show
    else
      flash[:danger] = t("static_pages.home.sorry")
      render "static_pages/home"
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t("users.new.success")
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
