# encoding: UTF-8
require "spec_helper"

describe "Animal pages" do
  subject { page }
  describe "index" do
    let(:user) {FactoryGirl.create(:user)}
    let(:animal) {FactoryGirl.create(:animal)}
    before(:each) do
      sign_in user
      visit animals_path
    end
    it {should have_link('Nytt dyr',href: new_animal_path)}

    describe "pagination" do
      before(:all) { 50.times {FactoryGirl.create(:animal)}}
      after(:all) { Animal.delete_all }

      it { should have_selector('div.pagination') }

      it "should list each animal" do
        Animal.paginate(page: 1).each do |animal|
          page.should have_selector('td', text: animal.id_tag)
        end
      end
    end
  end

  describe "animal creation" do
    let(:animal) {FactoryGirl.create(:animal)}
    before do
      visit animals_path
      click_link "Nytt dyr"
    end

    describe "with invalid information" do
      it "should not create animal" do
        expect { click_button "Lagre" }.not_to change(Animal, :count)
      end
    end

    describe "error message" do
      before {click_button "Lagre"}
      it {should have_content("error")}
    end

    describe "with valid information" do
      before do
        fill_in 'animal_id_tag', with: "101"
        fill_in 'animal_name',   with: "Sau 101"
        select '2012',    from: 'animal_birth_date_1i'
        select 'april',   from: 'animal_birth_date_2i'
        select '20',      from: 'animal_birth_date_3i'
        select 'Female',  from: 'animal_sex'
      end

      it "should create an animal" do
        expect { click_button "Lagre" }.to change(Animal, :count).by(1)
      end
    end

  end

end