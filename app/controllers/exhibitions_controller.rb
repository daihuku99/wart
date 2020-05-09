class ExhibitionsController < ApplicationController
  before_action :set_exhibition, only: [:show, :edit, :destroy]
  def index
    @exhibitions = Exhibition.all
  end

  def new
    @exhibition = Exhibition.new
    @cart_arts = CartArt.all
  end

  def create
    exhibition = current_user.exhibitions.new(exhibition_params)
    exhibition.save
    redirect_to thanks_path(exhibition)
  end

  def destroy
  end

  private
  def exhibition_params
    params.require(:exhibition).permit(:title, :detail, :start_date, :end_date)
  end

  def set_exhibition
    @exhibition = Exhibition.find(params[:id])
  end
end
