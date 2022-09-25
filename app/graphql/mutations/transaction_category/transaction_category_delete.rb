module Mutations
  module TransactionCategory
    class TransactionCategoryDelete < BaseMutation
      description 'Deletes a transaction_category by ID'

      field :transaction_category, Types::TransactionCategory::TransactionCategoryType, null: false

      argument :id, ID, required: true

      def resolve(id:)
        transaction_category = ::TransactionCategory.find(id)
        raise GraphQL::ExecutionError.new 'Error deleting transaction_category', extensions: transaction_category.errors.to_hash unless transaction_category.destroy

        { transaction_category: }
      end
    end
  end
end
