class PagesController < ApplicationController
	layout "login_home", :only => :home
  def home
		#flash.keep
		redirect_to user_path(current_user) if signed_in?
  end

  def groups
  end

  def contact
  end  
  
  def about
  end

  def help
  end
end
