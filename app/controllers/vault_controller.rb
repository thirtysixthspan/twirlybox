class VaultController < ApplicationController

  def show
    @user = User.find(:first,:conditions=>['twitter_name = ?', params[:id]])
    redirect_to :controller=>:box, :action=>"load_user" and return if !@user

    @items = @user.items      
    @item_types = ItemType.find(:all)
  end

  def send_item
    @user = User.find(:first,:conditions=>['twitter_name = ?', params[:id]])
    redirect_to :controller=>:box, :action=>"load_user" and return if !@user

    item_id = params[:itemid] || 1
    user_id = params[:userid] || 'jw'

    @to_user = User.find(:first,:conditions=>['twitter_name = ?', user_id])

    if !@to_user
      @to_user = User.new(:twitter_name=>user_id)
      @to_user.save
    end  
    
    item = Item.find_by_id(item_id)
    item.user_id = @to_user.id    
    item.save

    render :nothing => true
  end


end
