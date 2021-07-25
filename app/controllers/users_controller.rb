class UsersController < ApplicationController
  def index
    @users = User.page(params[:page]).reverse_order
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
    @posts = @posts.page(params[:page]).reverse_order
  end

  def edit
    @user = User.find(params[:id])
    if @user.id == current_user.id
      render 'edit'
    else
      redirect_to users_path
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end

  def bookmarks
    @user = current_user
    @bookmarked_posts = @user.bookmarked_posts
    @bookmarked_posts = @bookmarked_posts.page(params[:page])
  end

  private

  def user_params
    params.require(:user).permit(:name, :age, :sex, :job, :profile, :image)
  end
end
