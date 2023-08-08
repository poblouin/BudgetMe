module Types
  module Transaction
    class TransactionInputType < Types::BaseInputObject
      argument :amount, Float, required: true
      argument :date, GraphQL::Types::ISO8601Date, required: true
      argument :merchant_name, String, required: false
      argument :transaction_category_id, ID, required: true
    end
  end
end
