# frozen_string_literal: true

module Types
  class TransactionType < Types::BaseObject
    field :amount, Float
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :date, GraphQL::Types::ISO8601Date
    field :description, String
    field :id, ID, null: false
    field :transaction_category_id, Integer, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
