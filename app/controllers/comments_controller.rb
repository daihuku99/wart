class CommentsController < ApplicationController
  def create
    @art = Art.find(params[:art_id])
    @comment = current_user.comments.new(comment_params)
    @comment.art_id = @art.id
    @comment.save
    # redirect_to art_path(art)
  end

  def destroy
    art = Art.find(params[:art_id])
    comment = art.comments.find(params[:id])
    @id = params[:id]
    comment.user_id = current_user.id
    comment.destroy
    # redirect_to art_path(art)
  end

  private
  def comment_params
    params.require(:comment).permit(:comment)
  end
end
