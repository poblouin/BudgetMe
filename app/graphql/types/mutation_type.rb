module Types
  class MutationType < Types::BaseObject
    field :transaction_category_create, mutation: Mutations::TransactionCategory::TransactionCategoryCreate
    field :transaction_category_delete, mutation: Mutations::TransactionCategory::TransactionCategoryDelete
    field :transaction_category_update, mutation: Mutations::TransactionCategory::TransactionCategoryUpdate
    field :transaction_create, mutation: Mutations::Transaction::TransactionCreate
    field :transaction_delete, mutation: Mutations::Transaction::TransactionDelete
    field :transaction_update, mutation: Mutations::Transaction::TransactionUpdate
  end
end
