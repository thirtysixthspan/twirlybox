class GalleryController < ApplicationController

  def show
    @user = User.find(:first,:conditions=>['twitter_name = ?', params[:id]])
    redirect_to :controller=>:box, :action=>"load_user" and return if !@user

    @events = @user.events      
  end

  def load_user
    
  end

end
