class ExhibitionArtsController < ApplicationController
  before_action :authenticate_user!
  def show
  end

  def create #展覧会編集画面からartを追加する場合
    exhibition =  Exhibition.find(params[:id])
    exhibition_params[:exhibition_art_ids].each do |v| #配列でidが送られてくるのでeachで回す
       exhibition_art = ExhibitionArt.new
       if v != "" #配列の1つ目が空なので、それ以外を保存する
         exhibition_art.art_id = v.to_i #文字列で送られてくるので数字に変換
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
