class ExhibitionArtsController < ApplicationController
  before_action :authenticate_user!
  def show
  end

  def create
    exhibition =  Exhibition.find(params[:id])
    exhibition_params[:exhibition_art_ids].each do |v|
       exhibition_art = ExhibitionArt.new
       if v != ""
         exhibition_art.art_id = v.to_i
         exhibition_art.exhibition_id = exhibition.id
         exhibition_art.save
       end
    end
    redirect_to exhibition_path(exhibition)
  end

  def destroy
    exhibtion_art =ExhibitionArt.find(params[:id])
    exhibition = exhibtion_art.exhibition
    exhibtion_art.destroy
    redirect_to exhibition_path(exhibition)
  end

  private
  def exhibition_params
    params.require(:exhibition).permit({ :exhibition_art_ids=> [] })
  end
end
