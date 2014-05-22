FactoryGirl.define do

  factory :team do
    sequence(:name){|n| "testname#{n}" }
  end

end
