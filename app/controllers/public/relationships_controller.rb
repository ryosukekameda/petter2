class Public::RelationshipsController < ApplicationController
  def create
    current_user.follow(params[:user_id])
    flash[:notice] = "フォローしました"
    redirect_to request.referer
  end

  def destroy
    current_user.unfollow(params[:user_id])
    flash[:notice] = "フォローを解除しました"
    redirect_to request.referer
  end

  def followings
  end

  def followers
  end
end
