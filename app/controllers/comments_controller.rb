class CommentsController < ApplicationController

  def create
    post = Post.find params[:comment][:commentable_id]
    comment = Comment.build_from post, current_user.id, comment_params[:body]
    comment.parent_id = params[:comment][:parent_id]
    if comment.save
      flash[:'alert-success'] = "Thanks for your comment."
    else
      flash[:'alert-danger'] = "Oops. There was a problem saving your comment."
    end
    redirect_to post
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :commentable_name, :commentable_id, :commentable_type)
  end

end
