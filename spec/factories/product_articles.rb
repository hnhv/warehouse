FactoryBot.define do
  factory :product_article do
    product { association :product }
    article { association :article }
    quantity { Faker::Number.number(10) }
  end
end
