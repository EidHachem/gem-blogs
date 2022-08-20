class LikesController < ApplicationController
  def addlike
    @user = current_user
    @post = Post.find(params[:id])
    @like = @post.likes.new
    @like.post_id = @post.id
    @like.author_id = @user.id
    @like.save
    redirect_to "/user/#{current_user.id}/post/#{@post.id}"
  end
end
