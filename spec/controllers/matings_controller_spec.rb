require 'spec_helper'

describe MatingsController do
  let(:myowner) {FactoryGirl.create(:owner)}
  let(:myuser) {FactoryGirl.create(:user, owners: [myowner])}
  let(:myanimal) {FactoryGirl.create(:animal, owner: myowner)}
  let(:maleanimal) {FactoryGirl.create(:animal, owner: myowner, sex: 'male')}
  let(:mymating) {Mating.new(mating_date: "11/06/2013",
                             male_id: maleanimal.id,
                             animal_id: myanimal.id)}

  describe "GET 'new'" do
    it "returns http success" do
      get 'new', animal: myanimal
      response.should be_success
    end
  end

  describe "POST 'create'" do
    it "returns http success" do
      post :create, mymating.as_json
      response.should be_success
    end
  end

end
