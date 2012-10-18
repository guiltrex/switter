require 'spec_helper'

describe "User pages" do

  subject { page }

  describe "signup" do

    before { visit signup_path }

    let(:submit) { "Create my account" }
		let(:user1) { FactoryGirl.build(:user1) }
		
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
  
  describe "users" do  
      let(:user1) { FactoryGirl.create(:admin) }
      let(:login) { "Log in" }
  
			before do
				visit root_path 
				fill_in "session[email]",        with: user1.email
				fill_in "session[password]",     with: user1.password
				click_button login			
				visit users_path
			end	
			
			it{should have_selector('h1', text: 'All users')}
			it{should have_selector('title', text: full_title('All users'))}
			
			it "should list each user" do
				User.all.each do |user|
					page.should have_selector('li', text: show_name(user.username))
				end
			end	
			describe "pagination" do

				before(:all) { 50.times { FactoryGirl.create(:user) } }
				after(:all)  { User.delete_all }

				it { should have_selector('div.pagination') }

				it "should list each user" do
					User.paginate(page: 1, per_page: 25).order('created_at DESC').each do |user|
						page.should have_selector('li', text: show_name(user.username))
					end
				end
			end
			describe "delete user" do
				before(:all) { 10.times { FactoryGirl.create(:user) } }
				after(:all)  { User.delete_all }

        it { should have_link('delete', href: user_path(User.first)) }
        it "should be able to delete another user" do
          expect { click_link('delete') }.to change(User, :count).by(-1)
        end
        it { should_not have_link('delete', href: user_path(user1)) }	
			end	

	end

  
end
