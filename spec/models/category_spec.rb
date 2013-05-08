# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Category do
  before do
    @category1 = Category.new(name: "Category 1")
  end

  subject {@category1}

  it {should respond_to :name}

  it {should be_valid}
end
