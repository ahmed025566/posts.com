class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    respond_to do |f|
      f.html do
        @comment = Comment.new(comment_params)
        @post = Post.find(params[:post_id])
        @comment.user_id = current_user.id
        @comment.post_id = @post.id
        if @comment.save
          redirect_to user_post_path(user_id: @post.author_id, id: @post.id)
        else
          render :new, alert: 'An error has occurred while creating the comment'
        end
      end
      f.json do
        @comment = Comment.new(user: User.find(params[:user_id]), post: Post.find(params[:post_id]), **comment_params)
        render json: { message: 'Comment created successfully' }, status: 201 if @comment.save

        render json: @comment.errors, status: 401 unless @comment.save
      rescue ActiveRecord::RecordNotFound
        render json: { message: 'Invalid post or user id' }, status: 422
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    @comment.post.CommentsCounter = @comment.post.comments.count
    @comment.post.save
    redirect_to user_post_path(user: current_user, post: params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:Text)
  end
end
