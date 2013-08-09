# encoding: UTF-8
require "spec_helper"

describe "User pages" do
  let(:myuser) {FactoryGirl.create(:user)}
  let(:myowner) {FactoryGirl.create(:owner)}

  subject{page}

  describe"profile page" do
    before do
      myuser.owner = myowner
      sign_in myuser
      visit user_path(myuser)
    end
    it {should have_selector('h1', text: myuser.name)}
    it {should have_selector('li', text: myuser.email)}
    it {should have_link(myuser.owner.name, href: owner_path(myuser.owner))}
    it {should have_link('Edit', href: edit_user_path(myuser))}
    it {should have_link('Owners', href: owners_path)}
    it {should_not have_link('Create Owner', href: new_owner_path)}

    describe "when no owner exist" do
      before do
        Owner.delete_all
        visit user_path(myuser)
      end
      it {should_not have_link('Owners'), href: owners_path}
      it {should have_link('Create Owner', href: new_owner_path)}
    end

    describe "when no owner is assosiated with user" do
      before do
        myuser.owners.delete_all
        visit user_path(myuser)
      end
      it {should have_selector('h3', text: 'No owners assosiated')}
      it {should have_link('Owners'), href: owners_path}
      it {should have_link('Create Owner', href: new_owner_path)}
    end

  end
end