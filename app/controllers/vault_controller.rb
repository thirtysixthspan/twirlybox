class VaultController < ApplicationController

  def show
    @user = User.find(:first,:conditions=>['twitter_name = ?', params[:id]])
    redirect_to :controller=>:box, :action=>"load_user" and return if !@user

    @items = @user.items      
    @item_types = ItemType.find(:all)
  end

  def send_item
    params[:itemid]
    params[:userid]
  end


end
