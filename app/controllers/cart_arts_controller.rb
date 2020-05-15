class CartArtsController < ApplicationController
  before_action :authenticate_user!
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
    cart_art = CartArt.find(params[:id])
    cart_art.destroy
    redirect_to new_exhibition_path
  end

  def empty
    current_user.cart_arts.destroy_all
    redirect_to arts_path
  end
end
