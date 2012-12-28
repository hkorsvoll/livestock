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

class Animalrelation < ActiveRecord::Base
  attr_accessible :animal_id, :parent_id
  belongs_to :animal
  belongs_to :parent, :class_name => "Animal"
  accepts_nested_attributes_for :parent
end
