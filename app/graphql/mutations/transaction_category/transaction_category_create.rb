module Mutations
  module TransactionCategory
    class TransactionCategoryCreate < BaseMutation
      description 'Creates a new transaction_category'

      field :transaction_category, Types::TransactionCategory::TransactionCategoryType, null: false

      argument :params, Types::TransactionCategory::TransactionCategoryInputType, required: true

      def resolve(params:)
        transaction_category = ::TransactionCategory.new(**params)
        raise GraphQL::ExecutionError.new 'Error creating transaction_category', extensions: transaction_category.errors.to_hash unless transaction_category.save

        { transaction_category: }
      end
    end
  end
end
