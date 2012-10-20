class MicropostsController < ApplicationController
	before_filter :require_login, only: [:create, :destroy]
	before_filter :require_micropost_owner, only: :destroy

  def create
		@micropost=current_user.microposts.build(params[:micropost])
		if @micropost.save
			flash[:success]="Micropost created"
			redirect_to home_user_path(current_user)
		else
			@microposts = Micropost.paginate(page: session[:page_to])
			session.delete(:page_to)
			#flash.now[:notice]="Please try again later."
			render :template =>'users/home'
		end
  end

  def destroy
		@micropost.destroy
		flash[:success]="Micropost deleted."
		redirect_to home_user_path(current_user)
  end
  
  private
  def require_micropost_owner
  #we use find_by_id instead of find because the latter raises an exception 
  #when the micropost doesn’t exist instead of returning nil. 
		@micropost = current_user.microposts.find_by_id(params[:id])
		redirect_to home_user_path(current_user) if @micropost.nil?
	end
end
