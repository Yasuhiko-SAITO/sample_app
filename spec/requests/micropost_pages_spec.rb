require 'spec_helper'

#describe "MicropostPages" do
#  describe "GET /micropost_pages" do
#    it "works! (now write some real specs)" do
#      # Run the generator again with the --webrat flag if you #want to use webrat methods/matchers
#      get micropost_pages_index_path
#      response.status.should be(200)
#    end
#  end
#end

describe "Micropost pages" do
  subject {page}

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "micropost creation" do
    before { visit root_path }

    describe "with invalid information" do
      it "should not create a micropost" do
        expect { click_button "Post" }.not_to change(Micropost, :count)
      end  # it "should not create a micropost" do

      describe "error messages" do
        before { click_button "Post" }
        it { should have_content('error') }
      end  # describe "error messages" do
    end  # describe "with invalid information" do

    describe "with valid information" do
      before { fill_in 'micropost_content', with: "Lorem ipsum" }
      it "should create a micropost" do
        expect { click_button "Post" }.to change(Micropost, :count).by(1)
      end  # it "should create a micropost" do
    end  # describe "with valid information" do
  end  # describe "micropost creation" do

  describe "micropost destruction" do
    before { FactoryGirl.create(:micropost, user: user) }

    describe "as correct user" do
      before { visit root_path }
      it "should delete a micropost" do
        expect { click_link "delete" }.to change(Micropost, :count).by(-1)
      end  # it "should delete a micrpost" do
    end  # describe "as correct user" do
  end  # describe "micropost destruction" do
end  # describe "Micropost pages" do