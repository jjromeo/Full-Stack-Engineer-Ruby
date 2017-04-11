FactoryGirl.define do
  factory :favourite do
    comic_id { rand(1..10000) }
  end
end
