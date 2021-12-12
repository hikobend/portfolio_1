class RelationshipsController < ApplicationController
    before_action :authenticate_user!
    # フォローをする
    def create
        # ログインしている人がフォローをする。
        # current_userに紐づいたrelationshipsを作成する
        # follower_idを格納する
        # follower_idにパラメータから取ってきたuser_idを格納する
        following = current_user.relationships.build(follower_id: params[:user_id])
        following.save
        # 以前のpathに戻るようにする。もし見つからなかったら、root_pathに戻るようにする 
        redirect_to request.referrer, notice: 'フォローしました'
    end

    # フォローを解除する
    def destroy
        following = current_user.relationships.find_by(follower_id: params[:user_id])
        following.destroy
        # 以前のpathに戻るようにする。もし見つからなかったら、root_pathに戻るようにする 
        redirect_to request.referrer, alert: 'フォロー解除しました'
    end

end