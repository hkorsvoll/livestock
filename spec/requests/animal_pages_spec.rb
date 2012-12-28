require "spec_helper"

describe "Animal pages" do
  subject { page }
  describe "index" do
    let(:animal) {FactoryGirl.create(:animal)}
    before(:each) do
      visit animals_path
    end
    it {should have_link('Nytt dyr',href: new_animal_path)}
  end
end