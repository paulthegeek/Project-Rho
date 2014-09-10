FactoryGirl.define do
  factory :comic_series do
    name 'Series_Num_1'
    sub_id 234
    archived false

    factory :invalid_comic_series do
      name nil
      sub_id nil
      archived nil
    end

    factory :no_sub_id_comic_series do
      name 'Series_No_Sub'
      sub_id 0
      archived false
    end
  end
end
