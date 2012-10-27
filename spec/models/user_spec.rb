require 'spec_helper'

describe User do
	before do
		@user=User.new(username:'rex', email:'rex@switter.com', password:'rexdbpass', password_confirmation:'rexdbpass')
	end	
	subject{ @user }
	
	describe "respond to attributes" do
		it { should respond_to(:username) } 
		it { should respond_to(:email) }
		it { should respond_to(:password_digest) }
		it { should respond_to(:password) }
		it { should respond_to(:password_confirmation) }				
	end
	
	describe "valid name" do
		before do
			@user.username = 'a'*100
		end	
		it {should_not be_valid} 
	end
	
	describe "email not blank" do
		before do
			@user.email = ' '
			@user.password = ' ' 
		end	
		it {should_not be_valid} 
	end		
	
	describe "email in valid form" do
		before { @user.email = "foo@FOO" }
		it {should_not be_valid}
	end
	
	describe "uniqueness in email" do
		before do
			user_same_email= @user.dup
			user_same_email.save
		end
		it {should_not be_valid}
	end
	
	describe "passwd minimum 6 digits" do
		before { @user.password = "rexdb"}
		it {should_not be_valid}
	end
	
	describe "passwd matches passwd_conf" do
		before { @user.password_confirmation = 'rexdbmismatch' }
		it {should_not be_valid}
	end		
	
	describe "passwd_conf nonblanck" do
		before { @user.password_confirmation = ' ' }
		it {should_not be_valid}
	end		
	
	describe "remember token" do
    before { @user.save }
    its(:remember_token) { should_not be_blank }
  end
  
  describe "friends" do
		it {should respond_to(:friendships)}
		it {should respond_to(:friends)}
		it {should respond_to(:friend?)}
		it {should respond_to(:friend!)}
		it {should respond_to(:no_more_friend!)}		
	end
	
	describe "making friends" do
		let(:user1) {FactoryGirl.create(:user1)}
		before do
			@user.save
			@user.friend!(user1)
		end
		
		#attention to next line, it's very interesting!
		it {should be_friend(user1)}
		its(:friends) {should include(user1)}
	end
end
