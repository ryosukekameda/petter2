class Public::PostsController < ApplicationController
  def index
    @user = current_user
    @posts = Post.page(params[:post]).per(10)
    @tag_list = Tag.all
  end
  
  def new
    @user = current_user
    @post = Post.new
    @tags = Tag.all
  end
  
  def create
    @post = Post.new(post_params)
    @post.user = current_user
    @post.user_id = current_user.id
    if @post.save
       @post.save_tags(params[:post][:tag_ids]) if params[:post][:tag_ids].present?
       redirect_to post_path(@post), notice: '投稿完了しました'
    else
      @tags = Tag.all
      flash.now[:alert] = @post.errors.full_messages
      render :new
    end
  end

  def show
    @user = current_user
    @post = Post.find(params[:id])
    @comment = Comment.new
    @post_tags = @post.tags
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path
  end
  
  private
  
  def post_params
    params.require(:post).permit(:body, :post_image, tag_ids: [])
  end
end
