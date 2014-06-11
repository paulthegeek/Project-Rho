FactoryGirl.define do
  factory :publisher do
    name 'Pub_1'
    factory :invalid_publisher do
      name nil
    end
  end
end