# encoding: UTF-8
require 'spec_helper'
include AnimalsHelper

describe 'Get Years in Stock' do
  let(:myuser) {FactoryGirl.create(:user)}
  let(:myowner) {FactoryGirl.create(:owner)}

  subject { get_years_in_stock(myowner) }
  describe "when animals born in 3 years" do
    before do
      30.times { FactoryGirl.create(:animal, owner: myowner, birth_date: '2009-05-1')}
      30.times { FactoryGirl.create(:animal, owner: myowner, birth_date: '2010-05-1')}
      30.times { FactoryGirl.create(:animal, owner: myowner, birth_date: '2011-05-1')}
    end

    it {should eq [2009,2010,2011]}
    it {should be_kind_of(Array)}
  end

  describe "when no animals" do
    it {should be_kind_of(Array)}
    it {should eq []}
  end

end