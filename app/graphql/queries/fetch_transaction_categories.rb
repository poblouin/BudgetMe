module Queries
  class FetchTransactionCategories < Queries::BaseQuery
    type [Types::TransactionCategory::TransactionCategoryType], null: false

    def resolve
      TransactionCategory.all
    end
  end
end
