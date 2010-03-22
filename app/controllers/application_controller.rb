class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  filter_parameter_logging :password
  
  before_filter :add_stylesheets
  
  def initialize
    @stylesheets = []
    @website_title = "twirlybox"
  end

  def add_stylesheets
    ["#{controller_name}/_controller", "#{controller_name}/#{action_name}"].each do |stylesheet|
      @stylesheets << stylesheet if File.exists? "#{RAILS_ROOT}/public/stylesheets/#{stylesheet}.css"
    end
  end
  
  private

  def render_404
    render :template => 'error/error_404', :status => :not_found
  end
  
end
