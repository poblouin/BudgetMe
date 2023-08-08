module Types
  module Transaction
    class TransactionUpdateType < Types::BaseInputObject
      argument :amount, Float, required: false
      argument :date, GraphQL::Types::ISO8601Date, required: false
      argument :merchant_name, String, required: false
    end
  end
end
