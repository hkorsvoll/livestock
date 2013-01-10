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

require 'date'

class Animal < ActiveRecord::Base
  attr_accessible :birth_date, :death_date, :id_tag, :name, :sex, :mother_id, :father_id
  enum_attr :sex, %w(male female)
  belongs_to :owner
  belongs_to :mother, :class_name => 'Animal'#, :foreign_key => 'mother_id'
  belongs_to :father, :class_name => 'Animal'#, :foreign_key => 'father_id'
  has_many :children, :class_name => 'Animal', :foreign_key => 'mother_id'
  has_and_belongs_to_many :notes

  def females
    Animal.where("sex = 'female'")
  end

  def males
    Animal.where("sex = 'male'")
  end

  validates :id_tag, presence: true
  validates :sex, presence: true
  validates :birth_date, presence: true
  validate :validate_birth_date

  before_validation :update_parents
  
  private
    def update_parents
      self.mother = Animal.find(@mother_id) if @mother_id
      self.father = Animal.find(@father_id) if @father_id
    end

    def validate_birth_date
      if !birth_date.blank? and birth_date.future?
        errors.add(:birth_date, "is in the future!")
      end
    end
    
end
