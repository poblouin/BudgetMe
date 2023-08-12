FactoryBot.define do
  factory :transaction_category_mapping do
    merchant_name { 'Some Merchant' }

    association :transaction_category
  end
end
