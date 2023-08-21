FactoryBot.define do
  factory :transaction_category_mapping do
    merchant_name { 'Some Merchant' }

    transaction_category
  end
end
