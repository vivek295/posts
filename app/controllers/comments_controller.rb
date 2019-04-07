class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params)
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
  end

  def permanent_destroy
    @comment = Comment.find(params[:comment_id])
    @comment.destroy(true)
  end

  def restore
    @comment = Comment.only_deleted.find(params[:comment_id])
    @comment.restore
  end

  private

    def comment_params
      params.require(:comment).permit(:text)
    end

end