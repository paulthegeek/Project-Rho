FactoryGirl.define do
  factory :comic_series do
    name 'Series_Num_1'
    sub_id 234

    factory :invalid_comic_series do
      name nil
      sub_id nil
    end
  end
end