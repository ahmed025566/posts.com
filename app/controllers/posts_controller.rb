class PostsController < ApplicationController
  load_and_authorize_resource
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments).paginate(page: params[:page], per_page: 5)
    @comments = Comment.all
    @users = User.all

    respond_to do |format|
      format.html
      format.json { render json: @posts }
    end
  end

  def show
    @users = User.all
    @post = Post.find(params[:id])
    @comments = @post.comments
    respond_to do |format|
      format.html
      format.json { render json: { post: @post, comments: @comments } }
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    respond_to do |_format|
      f.html do
        if @post.save
          redirect_to user_posts_path(current_user), notice: 'Post was successfully created.'
        else
          render :new, status: :unprocessable_entity
        end
      end
      f.json do
        @post = Post.new(author: User.find(params[:author_id]), **post_params)
        render json: { message: 'post created successfully' }, status: 201 if @post.save

        render json: @post.errors, status: 401 unless @post.save
      rescue ActiveRecord::RecordNotFound
        render json: { message: 'Invalid data or user id' }, status: 422
      end
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.author.PostsCounter -= 1
    @post.author.save
    return unless @post.destroy

    redirect_to user_posts_path(current_user)
  end

  def post_params
    params.require(:post).permit(:Title, :Text)
  end
end
