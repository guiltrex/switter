class FriendshipsController < ApplicationController
  before_filter :require_login

  def create
    @user = User.find(params[:friendship][:friend_id])
    current_user.friend!(@user)
    redirect_to user_path(@user)
  end

  def destroy
		#check belongs_to association's four methods
    @user = Friendship.find(params[:id]).friend
    current_user.no_more_friend!(@user)
    redirect_to user_path(@user)
  end
end
