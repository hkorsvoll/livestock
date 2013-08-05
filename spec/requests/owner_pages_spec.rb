# encoding: UTF-8
require "spec_helper"

describe "Owner pages" do
  let(:myuser) {FactoryGirl.create(:user)}
  let(:myowner) {FactoryGirl.create(:owner)}

  subject { page }
  describe "index" do
    describe "without logging in" do
      before {visit owners_path}
      it { should have_selector('div.alert-notice', text: 'Please sign in')}
    end

    describe "with logged in user" do
      before do
        sign_in myuser
        visit owners_path
      end
      it { should have_selector('div.alert-notice', text: 'No owner is assosiated with this user')}
      it { should have_selector('title', text: 'All owners') }
      it { should have_selector('h1',    text: 'Registered owners in database') }
      it { should have_link('New Owner'), href:new_owner_path}
    end

    describe "with a logged in user that has owner" do
      before do
        myuser.set_owner(myowner)
        sign_in myuser
        visit owners_path
      end
      it { should_not have_selector('div.alert-notice', text: 'No owner is assosiated with this user')}
      it { should have_selector('title', text: 'All owners') }
      it { should have_selector('h1',    text: 'Registered owners in database') }
      it "should list each owner" do
        Owner.all.each do |owner|
          page.should have_selector('td',text: owner.name)
          page.should have_selector('td',text: owner.email)
          page.should have_link('Show', href: owner_path(owner))
          page.should have_link('Edit', href: edit_owner_path(owner))
          page.should have_link('Delete', href: owner_path(owner))
        end
      end
    end
  end

  describe "with signed in user" do
    before do
      sign_in myuser
      visit owner_path(myowner)
    end
    it { should have_selector('h1', text:myowner.name) }
    it { should have_selector('li', text:myowner.email) }
    it { should have_selector('li', text:myowner.pnum) }
    it { should have_selector('li', text:myowner.orgnum) }
    it { should have_selector('li', text:myowner.living_animals.count.to_s)}
    it { should have_link('Edit', href: edit_owner_path(myowner))}

    it "should create user assosiation" do
      expect {click_button('Assosiate owner '+myowner.name+' with user '+myuser.name)}.to change(myowner.users, :count).by(1)
    end
  end

  describe "when users are assosiated with owner" do
    before {
      FactoryGirl.create(:user, owner: @myowner)
      myowner.user = myuser
      sign_in myuser
      visit owner_path(myowner)
    }
    specify "should have one user" do
      myowner.users.count.should == 1
    end
    it "should list each user for owner" do
      myowner.users.each do |user|
        page.should have_selector('li', text: user.email)
      end
    end
  end

end