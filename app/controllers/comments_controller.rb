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
    respond_to do |format|
      format.js { render :action => "destroy" }
    end
  end

  def restore
    @comment = Comment.only_deleted.find(params[:comment_id])
    @comment.restore
    respond_to do |format|
      format.js { render :action => "destroy" }
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:text)
    end

end