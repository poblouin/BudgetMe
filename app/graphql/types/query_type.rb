module Types
  class QueryType < Types::BaseObject
    field :transaction_categories, resolver: Queries::FetchTransactionCategories
    field :transactions, resolver: Queries::FetchTransactions
  end
end
