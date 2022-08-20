class PostsController < ApplicationController
  def posts
    @user = User.find(params[:id])
  end

  def post
    @post = Post.find(params[:id])
  end

  def new
    @user = current_user
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(author_id: current_user.id, title: params[:title], text: params[:text])
    if @post.save
      redirect_to "/user/#{current_user.id}/post"
    else
      render :new
    end
  end
end
