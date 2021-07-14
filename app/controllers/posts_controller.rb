class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end
  # タグも同時に作成出来るメソッド
  def create
    @post = Post.new(post_params)
    tag_list = params[:post][:tag_ids].split(',')
    @post.user_id = current_user.id
    if @post.save
      @post.save_tags(tag_list)
      flash[:sucess] = "投稿しました"
      redirect_to post_path(@post)
    end
  end

  def edit
    @post = Post.find(params[:id])
    @tag_list = @post.tags.pluck(:tag_name), join(",")
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
    
  end

  def update
    @post = Post.find(params[:id])
    tag_list = params[:post][:tag_ids].split(',')
    if @post.update(post_params)
      @post.save_tags(tag_list)
      flash[:success] = '投稿を編集しました‼'
      redirect_to post_path(@post)
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :post_image, :content)
  end
end
