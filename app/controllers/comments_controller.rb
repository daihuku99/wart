class CommentsController < ApplicationController
  before_action :authenticate_user!
  def create
    @art = Art.find(params[:art_id])
    @comment = current_user.comments.new(comment_params)
    @comment.art_id = @art.id
    unless @comment.save #空コメントの場合はart詳細画面にリダイレクト
      redirect_to art_path(@art), notice: 'コメントが空欄です。'
    end
  end

  def destroy
    art = Art.find(params[:art_id])
    comment = art.comments.find(params[:id])
    @id = params[:id]
    comment.user_id = current_user.id
    comment.destroy
  end

  private
  def comment_params
    params.require(:comment).permit(:comment)
  end
end
