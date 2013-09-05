require "spec_helper"

describe AnimalsController do
  let(:myowner) {FactoryGirl.create(:owner)}
  let(:myuser) {FactoryGirl.create(:user, owners: [myowner])}
  let(:myanimal) {FactoryGirl.create(:animal, owner: myowner)}
  let(:myanimal2) {FactoryGirl.create(:animal, owner: myowner)}
  before {sign_in myuser}

  describe "GET 'show'" do
    it "returns http success" do
      get :show, id: myanimal
      http_success
      assigns(:animal).should eq(myanimal)
      expect_template(:show)
    end
    it "returns xhr success" do
      xhr :get, :show, id: myanimal
      http_success
      assigns(:animal).should eq(myanimal)
      expect_template(:show)
    end
  end

  describe "GET 'index'" do
    it "returns http success" do
      get :index
      http_success
      assigns(:animals).should eq(Animal.all)
      expect_template(:index)
    end
    it "returns xhr success" do
      xhr :get, :index
      http_success
      assigns(:animals).should eq(Animal.all)
      expect_template(:index)
    end
  end

  describe "GET 'edit'" do
    it "returns http success" do
      get :edit, id: myanimal
      http_success
      assigns(:animal).should eq(myanimal)
      expect_template(:edit)
    end
    it "returns xhr success" do
      xhr :get, :edit, id: myanimal
      http_success
      assigns(:animal).should eq(myanimal)
      expect_template(:edit)
    end
  end

  describe "GET 'new'" do
    it "returns http success" do
      get :new
      http_success
      assigns(:animal).should be_a_new(Animal)
      expect_template(:new)
    end
    it "returns xhr success" do
      xhr :get, :new
      http_success
      assigns(:animal).should be_a_new(Animal)
      expect_template(:new)
    end
  end

  describe "POST 'create'" do
    it "returns http success" do
      post :create, myanimal.as_json
      http_success
    end
    it "returns xhr success" do
      xhr :post, :create, animal: { name: "foo", id_tag: "101", birth_date: "2011-05-20"}
      http_success
    end
  end

  describe "POST 'update'" do
    it "returns http success" do
      post :update, id: myanimal, animal: { name: "foo", id_tag: "101", birth_date: "2011-05-20"}
      response.should redirect_to(animal_path(myanimal))
    end
    it "returns xhr success" do
      xhr :post, :update, id: myanimal, animal: { name: "foo", id_tag: "101", birth_date: "2011-05-20"}
      http_success
    end
  end

end