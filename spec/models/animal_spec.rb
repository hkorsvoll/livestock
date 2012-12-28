# == Schema Information
#
# Table name: animals
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  id_tag     :string(255)
#  birth_date :date
#  death_date :date
#  sex        :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  father_id  :integer
#  mother_id  :integer
#  owner_id   :integer
#

require "spec_helper"

describe Animal do
  let(:owner) {FactoryGirl.create(:owner)}

  before do
    @animal_1 = owner.animals.new( id_tag:     "113",
                                   birth_date: Date.today,
                                   sex:        "female")
  end

  subject { @animal_1 }

  it {should respond_to(:name)}
  it {should respond_to(:id_tag)}
  it {should respond_to(:sex)}
  it {should respond_to(:birth_date)}
  it {should respond_to(:death_date)}
  it {should respond_to(:mother)}
  it {should respond_to(:father)}
  it {should respond_to(:children)}
  it {should respond_to(:notes)}
  it {should respond_to(:owner)}

  it {should be_valid}

  describe "when date of birth is not present" do
    before {@animal_1.birth_date = nil}
    it { should_not be_valid }
  end

  describe "when date of birth is in the future" do
    before {@animal_1.birth_date = Date.tomorrow}
    it { should_not be_valid }
  end

  describe "when sex is not present" do
    before {@animal_1.sex = "" }
    it { should_not be_valid }
  end

  describe "when sex is other than male/female" do
    it "should raise an exception" do
      expect do
        @animal_1.sex = "hann"
      end.to raise_error(EnumeratedAttribute::InvalidEnumeration)
    end
  end

  describe "accessible attributes" do
    it "should not allow access to owner_id" do
      expect do
        Animal.new(owner_id: owner.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

end
