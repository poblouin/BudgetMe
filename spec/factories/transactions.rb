FactoryBot.define do
  factory :transaction do
    amount { '9.99' }
    date { Time.zone.today }
    merchant_name { 'Some Merchant' }

    association :transaction_category
  end
end
