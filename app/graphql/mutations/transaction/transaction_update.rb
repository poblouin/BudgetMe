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

        { transaction: }
      end
    end
  end
end
