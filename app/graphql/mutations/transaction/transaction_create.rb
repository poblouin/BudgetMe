module Mutations
  module Transaction
    class TransactionCreate < BaseMutation
      description 'Creates a new transaction'

      field :transaction, Types::Transaction::TransactionType, null: false

      argument :params, Types::Transaction::TransactionInputType, required: true

      def resolve(params:)
        transaction = ::Transaction.new(**params)
        raise GraphQL::ExecutionError.new 'Error creating transaction', extensions: transaction.errors.to_hash unless transaction.save

        { transaction: }
      end
    end
  end
end
