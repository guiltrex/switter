require 'spec_helper'

describe "Pages" do
  subject { page }
  describe "help_page" do

#  If there're many visits to the same page, we can replace all these visits with:
#  before { visit root_path }
#  when use subject{} to replace 'it "..." do ... end'
#  before{visit ...} is necessary, just 'visit ...' won't work 

#    it "should have the content switter" do
       #"visit ..." uses the Capybara function visit
       before{visit help_path}
       #uses the page variable (also provided by Capybara)
       it{should have_content('help')}
  end

  describe "home_page" do
#    it "should have the content page_tries" do   
       #"visit ..." uses the Capybara function visit
       before{visit root_path}

#check that the links on the layout go to the right pages
#	it "should..." do
#	visit ...
#   click_link "Home"
#   click_link "Sign up now!"
#   page.should have_selector 'title', text: full_title('About Us')
#	end             
       #uses the page variable (also provided by Capybara)
		it{should have_selector('title', text: full_title(''))}
  end     
  
	describe "sign_up_page" do
		before{visit signup_path}
		it{should have_selector('title', text: full_title('Sign up'))}
	end
	
	describe "profile page" do
		let(:user) { FactoryGirl.create(:user) }
		before { visit user_path(user) }
		it { should have_selector('h1',    text: user.username) }
		it { should have_selector('title', text: user.username) }
	end
	
	describe "home page to sign in" do
	
		let(:user1) { FactoryGirl.create(:user) }
		let(:login) { "Log in" }
		before do
			visit root_path      
    end

    describe "with invalid information" do
			before { click_button login}
			it { should have_selector('a', text: "Sign up now!") }
      it { should have_selector('div.alert.alert-error', text: 'Invalid') }			
		end
    
    describe "with valid information" do
			before do 
			  fill_in "session[email]",        with: user1.email
				fill_in "session[password]",     with: user1.password
				click_button login
			end
			it { should have_selector('h1',    text: user1.username) }
			it { should have_selector('title', text: user1.username) }
      it { should have_link('Profile', href: user_path(user1)) }			
			it { should have_link('Log out', href: logout_path) }
			
			describe "followed by signout" do
        before { click_link "Log out" }
        it { should have_selector('a', text: "Sign up now!") }
      end
    end
 	end
	
	describe "edit" do
        let(:user) { FactoryGirl.create(:user) }
				before { visit edit_user_path(user) }
				
				describe "user page" do
					it { should have_selector('h1', text: "Update your profile") }
				end
				
				describe "with invalid information" do
					before { click_button "Save changes" }

					it { should have_content('error') }
				end
				
				describe "with valid information" do
				  let(:new_username){user1.username+"yy"}
					before do 
						fill_in "user[username]",    	with: new_username
						fill_in "user[email]",        with: user1.email
						fill_in "user[password]",     with: user1.password
						fill_in "user[password_confirmation]", with: user1.password_confirmation
						click_button "Save changes"
					end
					it { should have_selector('h1', text: new_username) }								
				end
      end
end

