module Types
  module Transaction
    class TransactionUpdateType < Types::BaseInputObject
      argument :amount, Float, required: false
      argument :date, GraphQL::Types::ISO8601Date, required: false
      argument :description, String, required: false
    end
  end
end
