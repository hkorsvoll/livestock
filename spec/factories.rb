FactoryGirl.define do
  factory :animal do
    sequence(:name) { |n| "Animal #{n}"}
    sequence(:id_tag) { |n| "#{n}"}
    sex "female"
    birth_date Date.today
  end

  factory :owner do
    sequence(:name) { |n| "Owner #{n}"}
    sequence(:email)  { |n| "person_#{n}@example.com" }
    sequence(:pnum) { |n| (11223312345 + n).to_s}
  end
end