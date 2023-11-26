class Public::HomesController < ApplicationController
  before_action :authenticate_user!
  
  def top
    @user = current_user
    @posts = Post.page(params[:page])
    @tag_list = Tag.all
  end

  def about
  end
end
