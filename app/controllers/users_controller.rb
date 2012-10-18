class UsersController < ApplicationController
  before_filter :require_login, except: [:new, :create]
  before_filter :require_correct_user, except: [:new, :create, :index, :show]
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
		@user=User.find(params[:id])
		if @user.update_attributes(params[:user])
		  #since we have before_save :generate_token, everytime updating profile
		  #:remember_token column has also been changed. 
		  #Thus we have to update the cookies[:remember_token]
		  cookies[:remember_token] = @user.remember_token
			flash[:success]="Profile updated."
			redirect_to user_path(@user)
		else
			render "edit"
		end
  end
  
  def index
  end
end
