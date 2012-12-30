# == Schema Information
#
# Table name: owners
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  pnum       :string(255)
#  orgnum     :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Owner < ActiveRecord::Base
  attr_accessible :email, :name, :pnum, :orgnum

  has_many :animals
  has_many :notes

  validates :email, :presence => true
  validates :name, :presence => true
end