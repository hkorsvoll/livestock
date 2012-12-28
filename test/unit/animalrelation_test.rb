# == Schema Information
#
# Table name: animalrelations
#
#  id            :integer          not null, primary key
#  animal_id     :integer
#  parent_id     :integer
#  relation_type :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'test_helper'

class AnimalrelationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
