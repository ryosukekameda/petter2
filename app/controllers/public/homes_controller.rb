class Public::HomesController < ApplicationController
  before_action :authenticate_user!
  
  def top
    @user = current_user
    @posts = Post.all.order(created_at: :desc)
    @tag_list = Tag.all
  end

  def about
    @user = current_user
  end
end
