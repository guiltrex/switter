require 'spec_helper'

describe "MicropostPages" do
	subject{page}
  describe "profile page" do
    let(:user1) { FactoryGirl.create(:user1) }
    let!(:m1) { FactoryGirl.create(:micropost, user: user1, content: "Foo") }
    let!(:m2) { FactoryGirl.create(:micropost, user: user1, content: "Bar") }
		let(:login) {"Log in"}
    before do
			visit root_path 
			fill_in "session[email]",        with: user1.email
			fill_in "session[password]",     with: user1.password
			click_button login						
			visit user_path(user1)
		end
    it { should have_selector('h1',    text: user1.username) }
    it { should have_selector('title', text: full_title(user1.username)) }

    describe "microposts" do
      it { should have_content(m1.content) }
      it { should have_content(m2.content) }
      it { should have_content(user1.microposts.count) }
    end
  end
 
	describe "for non-signed-in users" do
				let(:user) { FactoryGirl.create(:user) }	
        describe "submitting to the create action" do
          before { post microposts_path }
          specify { response.should redirect_to(root_path) }
        end

        describe "submitting to the destroy action" do
          before { delete micropost_path(FactoryGirl.create(:micropost)) }
          specify { response.should redirect_to(root_path) }
        end
  end

  describe "micropost creation" do
    let(:user1) { FactoryGirl.create(:user) }
		let(:login) {"Log in"}
    before do
			visit root_path 
			fill_in "session[email]",        with: user1.email
			fill_in "session[password]",     with: user1.password
			click_button login
			visit home_user_path(user1)				
		end
    describe "with invalid information" do

      it "should not create a micropost" do
        expect { click_button "Post" }.not_to change(Micropost, :count)
      end

      describe "error messages" do
        before { click_button "Post" }
        it { should have_content('error') } 
      end
    end

    describe "with valid information" do

      before { fill_in 'micropost[content]', with: "Lorem ipsum" }
      it "should create a micropost" do
        expect { click_button "Post" }.to change(Micropost, :count).by(1)
      end
    end
  end
  
  describe "delete microposts" do
    let!(:user1) { FactoryGirl.create(:user) }
    let!(:user2) { FactoryGirl.create(:user) }
    let!(:m1) { FactoryGirl.create(:micropost, user: user1, content: "Foo") }
    let!(:m2) { FactoryGirl.create(:micropost, user: user2, content: "Bar") }    
		let(:login) {"Log in"}
    before do
			visit root_path 
			fill_in "session[email]",        with: user1.email
			fill_in "session[password]",     with: user1.password
			click_button login						
		end
		
    describe "by correct user" do
			before{visit user_path(user1)}
      it { should have_link("delete", href: micropost_path(m1)) }
      it "should be able to delete the micropost" do
        expect { click_link('delete') }.to change(Micropost, :count).by(-1)
      end 
    end

    describe "by wrong user" do
			before{visit user_path(user2)}
      it { should_not have_link("Delete", href: micropost_path(m2)) }
    end    
  end  
end
