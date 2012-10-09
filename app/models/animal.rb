class Animal < ActiveRecord::Base
  attr_accessible :birth_date, :death_date, :id_tag, :name, :sex, :mother_id, :father_id
  enum_attr :sex, %w(male female)
#  has_one :animalrelation
  belongs_to :mother, :class_name => 'Animal'#, :foreign_key => 'mother_id'
  belongs_to :father, :class_name => 'Animal'#, :foreign_key => 'father_id'
  has_many :children, :class_name => 'Animal', :foreign_key => 'mother_id'
  has_and_belongs_to_many :messages
#  accepts_nested_attributes_for :mother, :father#, :mother_id, :father_id
#  attr_writer :mother_id, :father_id
  
  before_validation :update_parents
  
  private
    def update_parents
      self.mother = Animal.find(@mother_id) if @mother_id
      self.father = Animal.find(@father_id) if @father_id
    end
    
end
