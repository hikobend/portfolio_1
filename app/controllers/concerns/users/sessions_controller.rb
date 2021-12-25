class Users::SessionsController < Devise::SessionsController

    def new_guest
        # ゲストユーザーがあれば取り出す、無ければ作成する
        user = User.guest
        sign_in user
        redirect_to user_path(current_user), notice: 'ゲストユーザーとしてログインしました。'
    end
end