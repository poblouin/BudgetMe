FactoryBot.define do
  factory :transaction do
    amount { '9.99' }
    date { '2022-09-06' }
    description { 'MyString' }
    transaction_category { nil }
  end
end
