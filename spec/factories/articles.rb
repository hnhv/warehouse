FactoryBot.define do
    factory :article do
      name { Faker::Lorem.word }
      quantity { Faker::Number.number(10) }
    end
  end