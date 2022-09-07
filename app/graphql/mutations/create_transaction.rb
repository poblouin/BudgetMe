module Mutations
  class CreateTransaction < Mutations::BaseMutation
    argument :params, Types::Input::TransactionInputType, required: true

    field :transaction, Types::TransactionType, null: false

    def resolve(params:)
      { transaction: Transaction.create!(params.to_h) }
    end
  end
end
