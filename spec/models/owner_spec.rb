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
  before { @owner = Owner.new(  name:   "Eigar1",
                                email:  "eigar@ein.no",
                                pnum:   "01020345678",
                                orgnum: "9100101010")}

  subject { @owner }

  it { should respond_to(:name)}
  it { should respond_to(:email)}
  it { should respond_to(:pnum)}
  it { should respond_to(:orgnum)}

  it { should be_valid }

  describe "when name is not present" do
    before { @owner.name = " "}
    it {should_not be_valid}
  end

  describe "when email is not present" do
    before { @owner.email = " " }
    it { should_not be_valid }
  end
end
