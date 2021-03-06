require 'spec_helper'

describe UsersController do
  let!(:myowner) {FactoryGirl.create(:owner)}
  let(:myuser) {FactoryGirl.create(:user, owners: [myowner])}
  let(:user2) {FactoryGirl.create(:user)}
  before {sign_in myuser}

  describe "GET 'show'" do
    it "returns http success" do
      get 'show', id: myuser.id
      http_success
    end
  end

  describe "GET 'index'" do
    it "returns http success" do
      get :index
      http_success
    end
  end

  describe "POST 'create'" do
    it "returns http success" do
      post 'create'
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
