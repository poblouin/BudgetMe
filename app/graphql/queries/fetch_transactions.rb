module Queries
  class FetchTransactions < Queries::BaseQuery
    type [Types::TransactionType], null: false

    def resolve
      Transaction.all
    end
  end
end
