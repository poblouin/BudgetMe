module Types
  module Transaction
    class TransactionUpdateType < Types::BaseInputObject
      argument :amount, Float, required: false
      argument :date, GraphQL::Types::ISO8601Date, required: false
      argument :merchant_name, String, required: false
      argument :transaction_category_id, ID, required: false
    end
  end
end
