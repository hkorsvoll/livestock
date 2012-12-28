# == Schema Information
#
# Table name: messages
#
#  id          :integer          not null, primary key
#  content     :text
#  date_from   :date
#  date_to     :date
#  category_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  owner_id    :integer
#

require "spec_helper"

describe Note do
  let(:owner) {FactoryGirl.create(:owner)}

  before do
    @note1 = owner.notes.new( content:    "Heisann du",
                              date_from:  Date.today)
  end

  subject {@note1}

  it {should respond_to(:content)}
  it {should respond_to(:date_from)}
  it {should respond_to(:date_to)}
  it {should respond_to(:owner)}
  it {should respond_to(:category)}

  it {should be_valid}

  describe "when note is blank" do
    before {@note1.content = " "}
    it {should_not be_valid }
  end
  describe "when owner_id is not present" do
    before {@note1.owner_id = nil}
    it {should_not be_valid }
  end
  describe "accessible attributes" do
    it "should not allow access to owner_id" do
      expect do
        Note.new(owner_id: owner.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end
end
