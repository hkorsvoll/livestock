require 'spec_helper'

describe Category do
  before do
    @category1 = Category.new(name: "Category 1")
  end

  subject {@category1}

  it {should respond_to :name}

  it {should be_valid}
end
