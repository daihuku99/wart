class CartArtsController < ApplicationController
  before_action :authenticate_user!
  def create
    art = Art.find(params[:art_id].to_i)
    cart_art = current_user.cart_arts.new
    cart_art.art_id = art.id
    unless current_user.add_art?(cart_art.art_id)
      cart_art.save
      redirect_to new_exhibition_path
    else
      redirect_to art_path(art), notice: "この作品はすでに選択されています"
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
