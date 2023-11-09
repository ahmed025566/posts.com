class PostsController < ApplicationController
  load_and_authorize_resource
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments).paginate(page: params[:page], per_page: 5)

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

  def destroy
    @post = Post.find(params[:id])
    return unless @post.destroy

    redirect_to user_posts_path(current_user)
  end

  def post_params
    params.require(:post).permit(:Title, :Text)
  end
end
