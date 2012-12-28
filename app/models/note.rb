# == Schema Information
#
# Table name: messages
#
#  id          :integer          not null, primary key
#  content     :text
#  date_from   :date
#  date_to     :date
#  category_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  owner_id    :integer
#

class Note < ActiveRecord::Base
  attr_accessible :date_from, :date_to, :content

  has_and_belongs_to_many :animals
  belongs_to :owner
  belongs_to :category

  validates :content, presence: true
  validates :date_from, presence: true
  validates :owner_id, presence: true
end
