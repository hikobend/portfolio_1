class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
    if @user != current_user
      redirect_to todos_path, alert: '不正なアクセスです'
    end
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to user_path notice: 'ユーザー情報を更新しました。'
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :profile, :profile_image)
  end
end
