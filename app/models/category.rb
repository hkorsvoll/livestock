class Category < ActiveRecord::Base
  attr_accessible :name
  has_many :notes

  validates :name, presence: true
end
