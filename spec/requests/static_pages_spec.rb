require 'spec_helper'

describe "Static Pages" do
  subject {page}
  describe "Front page" do
    before { visit root_path }
    it {should have_selector('h1', text: 'husdyrdatabasen')}
    it {should have_link('Om', href: about_path)}
    it {should have_link('Hjelp', href: help_path)}

    describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user)}
      before do
        sign_in user
        visit root_path
      end

      describe "should render sign out link" do
        it {should have_link('Logg ut', href: signout_path)}
      end

      describe "should render name of the current user" do
        it {should have_selector('li', text: user.name)}
      end
    end
  end

  describe "Help page" do
    before {visit help_path}
    it {should have_selector('h1', :text => 'Hjelp')}
  end

  describe "About page" do
    before {visit about_path}
    it {should have_selector('h1', text: "Om Livestock")}
  end
end