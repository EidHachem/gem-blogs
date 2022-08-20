class PostsController < ApplicationController
  def posts
    @user = User.find(params[:id])
    @post = Post.find(params[:id])
  end

  def post
    @post = Post.find(params[:id])
  end

  def new
    @user = current_user
    @post = Post.new
  end

  def addcomment
    @user = current_user
    @post = Post.find(params[:id])
    @comment = current_user.comments.new(text: params[:post][:comment])
    puts "--------------------------------------#{params[:comment]}"
    @comment.post_id = @post.id
    @comment.save
    redirect_to "/user/#{current_user.id}/post/#{@post.id}"
  end

  def addlike
    @user = current_user
    @post = Post.find(params[:id])
    @like = @post.likes.new
    @like.post_id = @post.id
    @like.author_id = @user.id
    @like.save
    redirect_to "/user/#{current_user.id}/post/#{@post.id}"
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
