FactoryBot.define do
  factory :transaction do
    amount { '9.99' }
    date { '2022-09-06' }
    merchant_name { 'Some Merchant' }

    association :transaction_category
  end
end
