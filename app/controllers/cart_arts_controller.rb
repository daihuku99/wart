class CartArtsController < ApplicationController
  def create
    art = Art.find(params[:art_id])
    cart_art = current_user.cart_arts.new
    cart_art_art = art.id
    p cart_art.errors
    cart_art.save
    redirect_to new_exhibition_path
  end

  def destroy
  end

  def empty
  end

  # private
  # def cart_art_params
  #   params.require(:cart_art).permit(:art_id)
  # end
end
