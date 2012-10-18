class UsersController < ApplicationController
  before_filter :require_login, except: [:new, :create]
  before_filter :require_correct_user, only: [:edit, :update]
  before_filter :require_admin, only: :destroy
  
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
    User.find(params[:id]).destroy
    flash.now[:success] = "User deleted."
#    return_page
		redirect_to users_path
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
		@users = User.paginate(page: params[:page], per_page: 25).order('created_at DESC')
#		store_page
  end
end
