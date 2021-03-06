# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#  remember_token  :string(255)
#  admin           :boolean
#

require 'spec_helper'

describe User do
  before { @user = User.new( :name => "Brukar 1",
                             :email => "brukar@eksempel.com",
                             :password => "tullepassord",
                             :password_confirmation => "tullepassord") }
  subject { @user }

  it { should respond_to(:name)}
  it { should respond_to(:email)}
  it { should respond_to(:password_digest)}
  it { should respond_to(:password)}
  it { should respond_to(:password_confirmation)}
  it { should respond_to(:remember_token)}
  it { should respond_to(:admin)}
  it { should respond_to(:authenticate)}
  it { should respond_to(:owners)}
  it { should respond_to(:owner)}

  it { should be_valid }
  it { should_not be_admin }

  describe "with admin attribute set to 'true'" do
    before do
      @user.save!
      @user.toggle!(:admin)
    end
    it {should be_admin}
  end

  describe "when name is not present" do
    before { @user.name = " " }
    it {should_not be_valid }
  end

  describe "when email is not present" do
    before { @user.email = " " }
    it { should_not be_valid }
  end

  describe "when password is not present" do
    before { @user.password = @user.password_confirmation = " "}
    it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before {@user.password_confirmation = "feil_passord"}
    it { should_not be_valid }
  end

  describe "when password confirmation is nil" do
    before {@user.password_confirmation = nil }
    it { should_not be_valid }
  end

  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by_email(@user.email)}

    describe "with valid password" do
      it { should == found_user.authenticate(@user.password)}
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid")}

      it { should_not == user_for_invalid_password}
      specify { user_for_invalid_password.should be_false}
    end
  end

  describe "with a password that's too short" do
    before {@user.password = @user.password_confirmation = "a"*5}
    it { should be_invalid }
  end

  describe "when name is too long" do
    before { @user.name = "a" * 51 }
    it {should_not be_valid}
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        @user.should_not be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.com A_US-ER@f.b.org frst.last@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        @user.should be_valid
      end
    end
  end

  describe "when email address is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end
    it { should_not be_valid }
  end

  describe "when email has upper case" do
    let(:mixed_case_email) { "MY@Doc.COM" }
    it "should be stored with lower case" do
      @user.email = mixed_case_email
      @user.save
      @user.reload.email.should == mixed_case_email.downcase
    end
  end

  describe "remember token" do
    before { @user.save }
    its(:remember_token) { should_not be_blank }
  end

  describe "accessible attributes" do
    it "should not allow access to admin" do
      expect do
        User.new(admin: true)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

  begin
    describe "owner association" do
      let!(:owner1) { FactoryGirl.create(:owner, users: [@user]) }
      it("should be associated with one owner") { @user.owners.count.should == 1 }
      specify("should owner have one user") { owner1.users.count.should == 1 }
      describe "when adding a second owner" do
        let!(:owner2) { FactoryGirl.create(:owner, users: [@user]) }
        it("should have two owners") { @user.owners.count.should == 2 }
        its(:owner) {should eq owner1}
        describe "and set owner to the second owner" do
          before {@user.set_owner(owner2)}
          its(:owner) {should eq owner2 }
          it("should still have two owners") { @user.owners.count.should == 2 }
        end
        describe "and set owner as third owner" do
          let!(:owner3) { FactoryGirl.create(:owner) }
          before {@user.set_owner(owner3)}
          its(:owner) {should eq owner3}
          it("should have three owner") { @user.owners.count.should == 3}
        end
      end
    end
  end
end
