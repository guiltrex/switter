module SessionsHelper
  
  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= User.find_by_remember_token(cookies[:remember_token]) if cookies[:remember_token]
  end
  
  def signed_in?
		!(current_user.nil?)
  end
  
  def correct_user?(user)
		user == current_user 
  end
end
