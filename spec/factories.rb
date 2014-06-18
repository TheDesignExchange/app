FactoryGirl.define do
  factory :user do
    email     { Faker::Internet.email }
    password  'password'
  end

  factory :owner do
    email     { Faker::Internet.email }
    password  'password'
  end

  factory :design_method do
    name      { Faker::Lorem.word }
    overview  { Faker::Lorem.paragraph }
    process   { Faker::Lorem.paragraph }
    principle { Faker::Lorem.paragraph }
    owner
  end

  factory :method_category do
    name    { Faker::Lorem.word }
  end

  factory :citation do
    text  { Faker::Lorem.sentence }
  end

  factory :comment do
    text  { Faker::Lorem.sentence }
    user
    design_method
  end

  factory :method_favorite do
    user
    design_method
  end

end
