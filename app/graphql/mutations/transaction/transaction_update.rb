# frozen_string_literal: true

module Mutations
  module Transaction
    class TransactionUpdate < BaseMutation
      description 'Updates a transaction by id'

      field :transaction, Types::Transaction::TransactionType, null: false

      argument :id, ID, required: true
      argument :params, Types::Transaction::TransactionUpdateType, required: true

      def resolve(id:, params:)
        transaction = ::Transaction.find(id)
        raise GraphQL::ExecutionError.new 'Error updating transaction', extensions: transaction.errors.to_hash unless transaction.update(**params)

        transaction.reload

        new_category_id = params.arguments&.keyword_arguments&.fetch(:transaction_category_id, nil)
        if new_category_id
          mapping = TransactionCategoryMapping.find_by(merchant_name: transaction.merchant_name)
          mapping&.update!(transaction_category_id: new_category_id)
        end

        { transaction: }
      end
    end
  end
end
