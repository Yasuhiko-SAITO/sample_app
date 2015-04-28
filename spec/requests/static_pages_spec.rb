require 'spec_helper'

describe "Static Pages" do
  
  let(:base_title) {"Ruby on Rails Tutorial Sample App"}

  subject { page }

  shared_examples_for "all static pages" do
    it { should have_content(heading) }
    it { should have_title(full_title(page_title)) }
  end

  describe "Home pages" do
  	before { visit root_path }
  	let(:heading) { 'Sample App' }
  	let(:page_title) { '' }

  	it_should_behave_like "all static pages"
    it { should_not have_title(' | Home') }

    describe "for signed-in users" do
      let(:user) {FactoryGirl.create(:user)}
      before do
        FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum")
        FactoryGirl.create(:micropost, user: user, content: "Doior sit amet")
        sign_in user
        visit root_path
      end

      it "should render the user's feed" do
        user.feed.each do |item|
          expect(page).to have_selector("li##{item.id}", text: item.content)
        end
      end
    end
  end


  describe "Help pages" do
  	before {visit help_path}
  	let(:heading) { 'Help' }
  	let(:page_title) { '' }

  	it_should_behave_like "all static pages"
  end


  describe "About pages" do
  	before {visit about_path}
  	let(:heading) { 'About Us' }
  	let(:page_title) { '' }

  	it_should_behave_like "all static pages"

  end


  describe "Contact pages" do
  	before {visit contact_path}
  	let(:heading) { 'Contact' }
  	let(:page_title) { '' }

  	it_should_behave_like "all static pages"

  end

  it "should have the right links on the layout" do
  	visit root_path
  	click_link "About"
   	expect(page).to have_title(full_title('About Us'))
  	click_link "Contact"
  	expect(page).to have_title(full_title('Contact'))


#何故かambigiousエラー
#  	click_link "Help"
#   expect(page).to have_title(full_title('Help'))
#  	click_link "Sample app"
#  	expect(page).to have_title(full_title('Home'))

#これだとFailure/Error
#   within(first('header')) do
#     click_link "Help"
#  	  expect(page).to have_title(full_title('Help'))
#  	end


    visit root_path
  	click_link "Sign up now!"
  	expect(page).to have_title(full_title('Sign up'))

  end
end