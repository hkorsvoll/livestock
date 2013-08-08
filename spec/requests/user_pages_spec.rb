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

  end
end