require 'spec_helper'

describe "InitPages" do
  describe "help_page" do
    it "should have the content switter" do
       #"visit ..." uses the Capybara function visit
       visit '/help'
       #uses the page variable (also provided by Capybara)
       page.should have_content('help')
    end
  end
  
  describe "home_page" do
     it "should have the content page_tries" do   
       #"visit ..." uses the Capybara function visit
       visit 'root'
       #uses the page variable (also provided by Capybara)
		page.should have_selector('title',
                  :text => "Switter")
    end
  end     
end

