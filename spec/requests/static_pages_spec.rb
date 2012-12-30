require 'spec_helper'

describe "Static Pages" do
  subject {page}
  describe "Front page" do
    before { visit root_path }
    it {should have_selector('h1', text: 'husdyrdatabasen')}
    it {should have_link('Om', href: about_path)}
    it {should have_link('Hjelp', href: help_path)}
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