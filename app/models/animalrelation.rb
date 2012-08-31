class Animalrelation < ActiveRecord::Base
  attr_accessible :animal_id, :parent_id
  belongs_to :animal
  belongs_to :parent, :class_name => "Animal"
  accepts_nested_attributes_for :parent
end
