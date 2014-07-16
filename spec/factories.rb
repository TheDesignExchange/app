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

  factory :discussion do
    title  { Faker::Lorem.sentence }
    description  { Faker::Lorem.sentence }
    user
  end

  factory :discussion_reply do
    text { Faker::Lorem.paragraph }
    user
    discussion
  end

  factory :method_favorite do
    user
    design_method
  end

  factory :company do
    name    { Faker::Company.name }
    domain  { Faker::Internet.domain_name }
    email   { Faker::Internet.email }
  end

  factory :case_study do
    mainImage         { Faker::Internet.url }
    title             { Faker::Lorem.sentence }
    url               { Faker::Internet.url }
    timePeriod        { Faker::Number.number(4) }
    development_cycle { rand(1...100) }
    design_phase      { rand(1...5) }
    project_domain    { rand(1...5) }
    customer_type     { rand(1...100) }
    user_age          { rand(1...100) }
    privacy_level     { rand(1...10) }
    social_setting    { rand(1...10) }
    description       { Faker::Lorem.paragraph }
    customerIsUser    { true }
    remoteProject     { true }
    company_id        { Faker::Number.number(10) }
    company
  end

  factory :contact do
    name        { Faker::Name.name }
    email       { Faker::Internet.email }
    phone       { Faker::PhoneNumber.phone_number }
    company_id  { Faker::Number.number(10) }
  end

  factory :resource do
    name              { Faker::Lorem.word }
    permission_to_use { true }
    type              { Faker::Lorem.word }
    company_id        { Faker::Number.number(10) }
  end

end
