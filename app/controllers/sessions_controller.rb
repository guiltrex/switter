class SessionsController < ApplicationController

  def create
		user=User.find_by_email(params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      flash[:success]="Welcome back, #{user.username.capitalize}!"
      if params[:session][:remember_me] == '1'
				cookies.permanent[:remember_token] = user.remember_token
				self.current_user = user
      else
				cookies[:remember_token] = user.remember_token
				self.current_user = user
			end
      redirect_back_or user_path(user)
    else
			flash.now[:error]="Invalid email or password"
			render 'pages/home', :layout => 'login_home'
		end
  end
  
  def destroy
		self.current_user = nil
		cookies.delete(:remember_token)
		redirect_to root_path
  end
end
