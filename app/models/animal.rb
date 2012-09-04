class Animal < ActiveRecord::Base
  attr_accessible :birth_date, :death_date, :id_tag, :name, :sex, :mother, :father
  enum_attr :sex, %w(male female)
  has_one :animalrelation
  has_one :mother, :through => :animalrelation, :source => :parent
  has_one :father, :through => :animalrelation, :source => :parent
#  validates :mother, :sex => "female"
  accepts_nested_attributes_for :mother, :father
end
