class ApplicationController < ActionController::Base
  protect_from_forgery
  
  private
  include SessionsHelper
  include UsersHelper
  def require_correct_user
		@user=User.find(params[:id])
		unless correct_user?(@user)
			#flash[:notice] = "No access to the page!"
			redirect_to root_path
		end  
  end
end
