class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @posts = Post.page(params[:page]).reverse_order
  end

  def new
    @post = Post.new
  end

  # タグを同時に作成する処理を含む
  def create
    @post = Post.new(post_params)
    tag_list = params[:post][:tag_ids].split(',')
    @post.user_id = current_user.id
    if @post.save
      @post.save_tags(tag_list)
      flash[:notice] = "投稿しました"
      redirect_to post_path(@post)
    else
      render 'new'
    end
  end

  def edit
    @post = Post.find(params[:id])
    @tag_list = @post.tags.pluck(:tag_name).join(",")
    if @post.user_id == current_user.id
      render 'edit'
    else
      redirect_to posts_path
    end
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
  end

  def update
    @post = Post.find(params[:id])
    tag_list = params[:post][:tag_ids].split(',')
    if @post.user_id == current_user.id
      @post.update(post_params)
      @post.save_tags(tag_list)
      flash[:notice] = '投稿を編集しました'
      redirect_to post_path(@post)
    else
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notice] = '投稿を削除しました'
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :post_image, :content)
  end
end
