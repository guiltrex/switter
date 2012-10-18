module UsersHelper
  def require_login
		unless signed_in?
			flash[:error] = "You must be logged in!"
			store_location
			redirect_to root_path
		end  
  end
  
end
