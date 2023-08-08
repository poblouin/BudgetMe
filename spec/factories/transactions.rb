FactoryBot.define do
  factory :transaction do
    amount { '9.99' }
    date { '2022-09-06' }
    merchant_name { 'Some Merchant' }
    transaction_category { create(:transaction_category) }
  end
end
