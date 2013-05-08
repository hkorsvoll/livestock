# == Schema Information
#
# Table name: matings
#
#  id          :integer          not null, primary key
#  animal_id   :integer
#  mating_date :date
#  uncertainty :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'spec_helper'

describe Mating do
  let(:animal) {FactoryGirl.create(:animal)}

  before do
    @mating = animal.add_mating(Date.today)
  end

  subject { @mating}

  it { should respond_to(:animal_id) }
  it { should respond_to(:mating_date)}
  it { should respond_to(:uncertainty)}

  it {should be_valid}


end
