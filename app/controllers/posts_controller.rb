class PostsController < ApplicationController
  def posts
    @user = User.find(params[:id])
    @post = @user.posts
  end

  def post
    @post = Post.includes(:author).find(params[:id])
  end

  def new
    @user = current_user
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(author_id: current_user.id, title: params[:post][:title], text: params[:post][:text])
    @post.likes_counter = 0
    @post.comments_counter = 0
    if @post.save
      redirect_to "/user/#{current_user.id}/post"
    else
      render :new
    end
  end
end
