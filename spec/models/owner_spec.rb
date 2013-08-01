# == Schema Information
#
# Table name: owners
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  pnum       :string(255)
#  orgnum     :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Owner do
  before do
    @owner = Owner.new(name: "Eigar1",
                       email: "eigar@ein.no",
                       pnum: "01020345678",
                       orgnum: "9100101010")
  end

  subject { @owner }

  it { should respond_to(:name)}
  it { should respond_to(:email)}
  it { should respond_to(:pnum)}
  it { should respond_to(:orgnum)}
  it { should respond_to(:users)}
  it { should respond_to(:user)}
  it { should respond_to(:animals)}

  it { should be_valid }

  describe "when name is not present" do
    before { @owner.name = " "}
    it {should_not be_valid}
  end

  describe "when email is not present" do
    before { @owner.email = " " }
    it { should_not be_valid }
  end

  describe "animal association" do
    before { @owner.save }
    let!(:alive_animal) do
      FactoryGirl.create(:animal, owner: @owner, birth_date: 1.year.ago)
    end
    let!(:dead_animal) do
      FactoryGirl.create(:animal, owner: @owner, birth_date: 1.year.ago, death_date: 1.day.ago)
    end

    it "should have 2 animals" do
      @owner.animals.count.should == 2
    end

    it "should have 1 living animal" do
      @owner.living_animals.count.should == 1
    end

    it "should have 1 living female animal" do
      @owner.female_animals.count.should == 1
    end
  end

  begin
    describe "user association" do
      let!(:user1) { FactoryGirl.create(:user, owners: [@owner]) }
      it("should be associated with one user") { @owner.users.count.should == 1 }
      its(:user) {should eq user1}
      describe "when adding a second user" do
        let!(:user2) { FactoryGirl.create(:user, owners: [@owner]) }
        it("should have two users") { @owner.users.count.should == 2 }
        describe "and set user to the second user" do
          before {@owner.set_user(user2)}
          its(:user) {should eq user2}
          it("should still have two users") { @owner.users.count.should == 2 }
        end
        describe "and set user as third user" do
          let!(:user3) { FactoryGirl.create(:user) }
          before {@owner.set_user(user3)}
          its(:user) {should eq user3}
          it("should have three users") { @owner.users.count.should == 3}
        end
      end
    end
  end

end
