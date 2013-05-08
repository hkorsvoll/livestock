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

class Mating < ActiveRecord::Base
  attr_accessible :mating_date, :uncertainty

  belongs_to :animal

end
