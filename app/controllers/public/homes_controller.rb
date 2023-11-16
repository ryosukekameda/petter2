class Public::HomesController < ApplicationController
  def top
    @user = current_user
    @posts = Post.all
    @tag_list = Tag.all
  end

  def about
  end
end
