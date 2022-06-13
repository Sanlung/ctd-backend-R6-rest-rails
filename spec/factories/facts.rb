require 'faker'

FactoryBot.define do
  factory :fact do |f|
    f.fact_text { Faker::ChuckNorris.fact }
    f.likes { Faker::Number.number(digits: 3).to_i }
    association :member
  end
end
