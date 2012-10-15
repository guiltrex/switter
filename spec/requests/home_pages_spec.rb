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
end

