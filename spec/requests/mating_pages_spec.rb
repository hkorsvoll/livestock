require "spec_helper"

describe 'Matings' do
  let(:myuser)        {FactoryGirl.create(:user)}
  let(:myowner)       {FactoryGirl.create(:owner)}

  let(:animal_female) {FactoryGirl.create(:animal, owner: myowner)}
  let(:animal_male)   {FactoryGirl.create(:animal, owner: myowner, sex: :male)}

  subject { page }
  describe 'new' do
    before do
      visit new_mating_path(animal: animal_female)
    end
    it {should have_selector('h1', text: 'Registrer parring for')}
  end
end