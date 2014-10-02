FactoryGirl.define do
  factory :comic do
    title 'Comic Title 1'
    price 3.99
    image_id 1
    comic_series_id 1
    publisher_id 1 
    release_date DateTime.new(2014,8,12)
    variant false
    reprint false

    factory :invalid_comic do
      title nil
      price 3.99
      image_id 1
      comic_series_id 1
      publisher_id 1 
      release_date DateTime.new(2014,8,12)
      variant true
      reprint false
    end
    
    factory :comic_variant do
      title 'Comic Title 1'
      price 3.99
      image_id 1
      comic_series_id 1
      publisher_id 1 
      release_date DateTime.new(2014,8,12)
      variant true
      reprint false
    end

    factory :comic_reprint do
      title 'Comic Title 1'
      price 3.99
      image_id 1
      comic_series_id 1
      publisher_id 1 
      release_date DateTime.new(2014,8,12)
      variant false
      reprint true
    end
  end
end