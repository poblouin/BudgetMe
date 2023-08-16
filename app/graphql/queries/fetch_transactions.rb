module Queries
  class FetchTransactions < Queries::BaseQuery
    type [Types::Transaction::TransactionType], null: false
    argument :from, GraphQL::Types::ISO8601Date, required: false
    argument :to, GraphQL::Types::ISO8601Date, required: false

    def resolve(from: nil, to: nil)
      Transaction.where(date: from..to)
    end
  end
end
