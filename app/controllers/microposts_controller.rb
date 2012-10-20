class MicropostsController < ApplicationController
	before_filter :require_login, only: [:create, :destroy]
	before_filter :require_correct_user, only: :destroy

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
  
  def index
  end

  def destroy
		
  end
end
