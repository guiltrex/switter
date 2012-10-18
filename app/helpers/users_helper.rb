module UsersHelper
  def require_login
		unless signed_in?
			flash[:error] = "You must be logged in!"
			redirect_to root_path
		end  
  end
  
end
