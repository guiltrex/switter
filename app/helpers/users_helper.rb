module UsersHelper
  
  def require_login
		unless signed_in?
			flash[:error] = "You must be logged in!"
			store_location
			redirect_to root_path
		end  
  end

	def current_user?(user)
		user == current_user
	end

  def current_user
    @current_user ||= User.find_by_remember_token(cookies[:remember_token]) if cookies[:remember_token]
  end
  
  def require_admin
		unless current_user.admin?
			redirect_to users_path
		end  
  end	

#  def return_page
#    redirect_to users_url+"?page=#{session[:page_to]}"
#  end

  def store_page
    session[:page_to] = params[:page]
  end			
end
