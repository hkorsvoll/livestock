require 'spec_helper'

describe OwnersController do
  let!(:myowner) {FactoryGirl.create(:owner)}
  let(:myuser) {FactoryGirl.create(:user, owners: [myowner])}
  before {sign_in myuser}

  describe "GET 'show'" do
    it "returns http success" do
      get 'show', id: myowner.id
      http_success
    end
  end

  describe "GET 'index'" do
    it "returns http success" do
      get :index
      http_success
      expect_template(:index)
    end
  end

  describe "GET #show" do
    let(:owner) { stub(:owner) }
    before { Owner.stub(:find).and_return(owner)}
    it "populates @owner" do
      get :show, id: owner
      http_success
      assigns(:owner).should eq(owner)
    end
  end

  describe "GET 'create'" do
    it "returns http success" do
      get 'create'
      http_success
    end
  end

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      http_success
    end
  end

end
