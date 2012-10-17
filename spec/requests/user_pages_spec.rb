require 'spec_helper'

describe "User pages" do

  subject { page }

  describe "signup" do

    before { visit signup_path }

    let(:submit) { "Create my account" }
		let(:user1) { FactoryGirl.build(:user) }
		
    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "user[username]",    	with: user1.username
        fill_in "user[email]",        with: user1.email
        fill_in "user[password]",     with: user1.password
        fill_in "user[password_confirmation]", with: user1.password_confirmation
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

			describe "has correct response" do   
				before { click_button submit }
				it { should have_content(user1.username) }
				
				it "should send a confirmation email to the new user" do
					last_email.to.should include(user1.email)
				end
				
				it { should have_link('Log out', href: logout_path) }
			
			end
    end
  end
end
