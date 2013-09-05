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
      it { should have_link('New Owner', href: new_owner_path)}
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

  describe "profile" do
    before do
      sign_in myuser
      visit owner_path(myowner)
    end
    it { should have_selector('h1', text:myowner.name) }
    it { should have_selector('li', text:myowner.email) }
    it { should have_selector('li', text:myowner.pnum) }
    it { should have_selector('li', text:myowner.orgnum) }
    it { should have_selector('li', text:myowner.prodnum) }
    it { should have_selector('li', text:myowner.living_animals.count.to_s)}
    it { should have_link('Edit', href: edit_owner_path(myowner))}
    it { should have_link('Close', href: owners_path)}

    describe "when logged in user is not assosiated with owner" do
      it "should create user assosiation" do
        expect {click_button('Add me to this owner')}.to change(myowner.users, :count).by(1)
      end
    end

    describe "when logged in user is assosiated with owner" do
      before do
        myowner.user = myuser
        visit owner_path(myowner)
      end
      it "should remove user assosiation" do
        expect {click_button('Remove me from this owner')}.to change(myowner.users, :count).by(-1)
      end
    end
  end

  describe "when users are assosiated with owner" do
    before {
      3.times {FactoryGirl.create(:user, owner: myowner)}
      myowner.set_user(myuser)
      sign_in myuser
      visit owner_path(myowner)
    }
    it "should list each user for owner" do
      myowner.users.each do |user|
        page.should have_selector('li', text: user.name)
      end
    end
  end

  describe "new" do
    before do
      sign_in myuser
      visit new_owner_path
    end

    let(:submit) {"Create Owner"}

    describe "with invalid information" do
      it "should not create an owner" do
        expect {click_button submit}.not_to change(Owner, :count)
      end

      describe "after submission" do
        before {click_button submit}

        it{should have_selector('title', Text: 'Create Owner')}
        it{should have_content('error')}
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name",   with: "Example Owner"
        fill_in "Email",  with: "owner@example.com"
      end
      it "should create an owner" do
        expect {click_button submit}.to change(Owner, :count).by(1)
      end
      describe "after saving the owner" do
        before { click_button submit }
        let(:owner) { Owner.find_by_email('owner@example.com') }

        it { should have_selector('title', text: owner.name) }
        it { should have_selector('div.alert.alert-success', text: 'Owner created') }
      end
    end
  end

  describe "edit" do
    before do
      sign_in myuser
      visit edit_owner_path(myowner)
    end

    let(:submit) {"Update Owner"}
    let(:newowner) {FactoryGirl.create(:owner, orgnum: "897516598", prodnum: "1411234056")}
    describe "page" do
      it { should have_selector('title', Text: 'Edit '+myowner.name)}
      it { should have_css('input#owner_name')}
      it { should have_css('input#owner_pnum') }
      it { should have_css('input#owner_email') }
      it { should have_css('input#owner_orgnum') }
      it { should have_css('input#owner_prodnum') }
    end
    describe "when changing some data" do
      before do
        fill_in :name,      with: myowner.name
        fill_in :email,     with: myowner.email
        fill_in :orgnum,    with: newowner.orgnum
        fill_in :prodnum,   with: newowner.prodnum
      end

      it "should not create a new owner" do
        expect {click_button submit}.not_to change(Owner, :count)
      end

      describe "after updating owner" do
        before {click_button submit}
        it { should have_selector('div.alert.alert-success', text: 'Owner updated') }
      end
    end
  end

end