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
#  male_id     :integer
#

class Mating < ActiveRecord::Base
  attr_accessible :mating_date, :uncertainty, :animal_id, :male_id

  belongs_to :animal
  belongs_to :male, :class_name => 'Animal'
end
