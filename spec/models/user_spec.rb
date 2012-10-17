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
end
