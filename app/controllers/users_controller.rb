class UsersController < ApplicationController
  
  def new
		@user=User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
    	cookies[:remember_token] = @user.remember_token
			current_user = @user
			UserMailer.signup_confirmation(@user).deliver
      flash[:success] = "Sign up successfully. A confirmation email has been sent!"      
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end
  
  def show
		@user=User.find(params[:id])
  end
  
  def destroy
  end
  
  def edit
		@user=User.find(params[:id])
	end
  
  def update
  end
  
  def index
  end
end
