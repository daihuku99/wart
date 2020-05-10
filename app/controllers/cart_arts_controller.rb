class CartArtsController < ApplicationController
  def create
    art = Art.find(params[:art_id].to_i)
    cart_art = current_user.cart_arts.new
    cart_art.art_id = art.id
    if cart_art.save
      redirect_to new_exhibition_path
    else
      @arts = Art.all
      redirect_to arts_path, notice: "追加に失敗しました"
    end
  end

  def destroy
  end

  def empty
  end
end
