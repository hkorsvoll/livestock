class Message < ActiveRecord::Base
  attr_accessible :category_id, :date_from, :date_to, :message, :animal_ids
  has_and_belongs_to_many :animals
end
