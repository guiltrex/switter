require 'spec_helper'

describe Friendship do
  let(:user) do 
      FactoryGirl.create(:user)
  end
  let(:user1) do
      FactoryGirl.create(:user1)
  end
  let(:friendship) do 
      user.friendships.create(friend_id: user1.id)
  end  
	subject{friendship}
	
	it {should be_valid}
  describe "friend attribute" do
		it {should respond_to(:friend)}
		it {should respond_to(:user)}
		its(:user) {should == user}
		its(:friend) {should == user1}
		it "should not access to user_id" do
			expect do
				Friendship.new(user_id: user.id)
			end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
		end
  end
  
  describe "friend_id presence" do
		before do
			friendship.friend_id = nil
		end
		it {should_not be_valid}
  end

  describe "user_id presence" do
		before do
			friendship.user_id = nil
		end
		it {should_not be_valid}
  end  
  	
  describe "Adding user as user1's friend" do
		before{user.friendships.create(friend_id: user1.id)}
  	it "should have the friends match from user to user1" do
			user.friends.should include(user1)
		end
  	it "should have the friends match from user1 to user" do
			user1.friends.should include(user)
		end
  
		 describe "Deleting user1 from user's friends" do
			before do
		#		"user.friends << user1" works well
		#		"user1.friends.delete(user)" can't work correctly here...only delete one item in Friendship
				user.friendships.find_by_friend_id(user1.id).destroy	
			end
			it "should have the friends match from user to user1" do
				user.friends.should_not include(user1)
			end
			it "should have the friends match from user1 to user" do
				user1.friends.should_not include(user)
			end
		end
  end 
end
