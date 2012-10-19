require 'spec_helper'

describe Micropost do

	let(:user) { FactoryGirl.create(:user) }
	describe "attributes" do
		before { @micropost = user.microposts.build(content: "Lorem ipsum") }

		subject { @micropost }

		it { should respond_to(:content) }
		it { should respond_to(:user_id) }
		it { should respond_to(:user) }
		its(:user) { should == user } 
		 
		it { should be_valid }

		describe "when user_id is not present" do
			before { @micropost.user_id = nil }
			it { should_not be_valid }
		end

		describe "accessible attributes" do
			it "should not allow access to user_id" do
				expect do
					Micropost.new(user_id: user.id)
				end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
			end    
		end
		
		describe "with blank content" do
			before { @micropost.content = " " }
			it { should_not be_valid }
		end

		describe "with content that is too long" do
			before { @micropost.content = "a" * 255 }
			it { should_not be_valid }
		end		

  end
  
  describe "microposts association" do
    let!(:older_micropost) do 
      FactoryGirl.create(:micropost, user: user, created_at: 1.day.ago)
    end
    let!(:newer_micropost) do
      FactoryGirl.create(:micropost, user: user, created_at: 1.hour.ago)
    end
    it "should have the right microposts in the right order" do
      user.microposts.should == [newer_micropost, older_micropost]
    end		
    
    it "should destroy associated microposts" do
			#attention to 'dup' here, it's necessary to make this test work!
      microposts = user.microposts.dup
      user.destroy
      microposts.should_not be_empty
      microposts.each do |micropost|
        Micropost.find_by_id(micropost.id).should be_nil
      #If using find(), this part should be:
      #lambda do 
			#	   Micropost.find(micropost.id)
			#  end.should raise_error(ActiveRecord::RecordNotFound)
      end
      
    end
  end  
  
end

