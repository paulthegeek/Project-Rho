FactoryGirl.define do
  factory :creator do
    name 'Jaylen'
    role 'artist'
    factory :invalid_creator do
      name nil
    end
  end
end
