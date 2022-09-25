module Mutations
  module TransactionCategory
    class TransactionCategoryUpdate < BaseMutation
      description 'Updates a transaction_category by id'

      field :transaction_category, Types::TransactionCategory::TransactionCategoryType, null: false

      argument :id, ID, required: true
      argument :params, Types::TransactionCategory::TransactionCategoryInputType, required: true

      def resolve(id:, params:)
        transaction_category = ::TransactionCategory.find(id)
        raise GraphQL::ExecutionError.new 'Error updating transaction_category', extensions: transaction_category.errors.to_hash unless transaction_category.update(**params)

        { transaction_category: }
      end
    end
  end
end
