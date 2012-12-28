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

require 'test_helper'

class AnimalTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
