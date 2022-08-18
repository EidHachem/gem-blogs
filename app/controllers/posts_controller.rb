class PostsController < ApplicationController
  def posts
    @user = User.find(params[:id])
  end

  def post
    @post = Post.find(params[:id])
  end
end
