class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.save
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    respond_to do |format|
      format.js
    end
  end

  def permanent_destroy
    @post = Post.only_deleted.find(params[:post_id])
    @post.comments.only_deleted.each do |comment|
      comment.destroy(true)
    end
    @post.destroy(true)
    respond_to do |format|
      format.js { render :action => "destroy" }
    end
  end

  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def archived_posts
    @posts = Post.only_deleted.order(created_at: :desc)
  end

  def restore
    @post = Post.only_deleted.find(params[:post_id])
    @post.comments.only_deleted.each do |comment|
      comment.restore
    end
    @post.restore
    respond_to do |format|
      format.js { render :action => "destroy" }
    end
  end

  private
    def post_params
      params.require(:post).permit(:caption)
    end
end
