class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts
    @comments = Comment.all
    @users = User.all
  end

  def show
    @users = User.all
    @post = Post.find(params[:id])
    @comments = @post.comments
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      redirect_to user_posts_path(current_user), notice: 'Post was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def post_params
    params.require(:post).permit(:Title, :Text)
  end
end
