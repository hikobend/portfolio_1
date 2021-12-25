class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    # idをログインしている人以外のuser全てを取ってくる。
    # ゲストユーザー以外を取ってくる
    @users = User.all.where.not(email: "guest@example.com")
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

  # あるユーザーがフォローしている人全員を取得するアクションを定義
  def followings
    user = User.find(params[:id])
    # userがフォローしている人全員を取ってくる
    # followingsはrelationship.rbで定義したもの
    @users = user.followings
  end

  def followers
    user = User.find(params[:id])
    # userのフォロワーを人全員を取ってくる
    @users = user.followers
  end
    
  private
  def user_params
    params.require(:user).permit(:name, :email, :profile, :profile_image)\
  end
end
