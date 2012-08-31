class Animal < ActiveRecord::Base
  attr_accessible :birth_date, :death_date, :id_tag, :name, :sex, :parent
  enum_attr :sex, %w(male female)
  has_one :animalrelation
  has_one :parent, :through => :animalrelation
#  has_one :parent, :class_name => "Animal", :foreign_key => "parent_id"
#  accepts_nested_attributes_for :animalrelation
  accepts_nested_attributes_for :parent
end
