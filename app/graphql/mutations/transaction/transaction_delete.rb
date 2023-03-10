# frozen_string_literal: true

module Mutations
  module Transaction
    class TransactionDelete < BaseMutation
      description 'Deletes a transaction by ID'

      field :transaction, Types::Transaction::TransactionType, null: false

      argument :id, ID, required: true

      def resolve(id:)
        transaction = ::Transaction.find(id)
        raise GraphQL::ExecutionError.new 'Error deleting transaction', extensions: transaction.errors.to_hash unless transaction.destroy

        { transaction: }
      end
    end
  end
end
