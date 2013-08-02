# encoding: UTF-8
require "spec_helper"

describe "Animal pages" do
  let(:myuser) {FactoryGirl.create(:user)}
  let(:myowner) {FactoryGirl.create(:owner)}

  subject { page }
  describe "index page without logging in" do
    before {visit animals_path}

    it { should have_selector('div.alert-notice', text: 'Please sign in')}
  end

  describe "index page logged in with user that have no owner" do
    before do
      sign_in myuser
      visit animals_path
    end

    it {should have_selector('h1', text: 'No owner')}
  end

  describe "index page with signed in user and assosiated owner" do
    before do
      myuser.set_owner(myowner)
      sign_in myuser
      visit animals_path
    end

    it {should have_link('Nytt dyr',href: new_animal_path)}

    describe "pagination" do
      before {
        50.times { FactoryGirl.create(:animal, owner: myowner) }
        visit animals_path
      }

      specify "user should have access to 50 animals" do
        myuser.owners.first.animals.count.should == 50
      end

      specify "User should have one owner" do
        myuser.owners.count.should == 1
      end

      it { should have_selector('div.pagination') }

      it "should list each animal" do
        myowner.animals.paginate(page: 1).each do |animal|
          page.should have_selector('td', text: animal.id_tag)
        end
      end
    end
  end


  describe "animal creation" do
    before do
      myuser.set_owner(myowner)
      sign_in myuser
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
        select 'April',   from: 'animal_birth_date_2i'
        select '20',      from: 'animal_birth_date_3i'
        select 'Female',  from: 'animal_sex'
      end

      it "should create an animal" do
        expect { click_button "Lagre" }.to change(Animal, :count).by(1)
      end
    end

  end

end