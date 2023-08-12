# frozen_string_literal: true

module Types
  module Transaction
    class TransactionType < Types::BaseObject
      field :amount, Float, null: false
      field :created_at, GraphQL::Types::ISO8601DateTime, null: false
      field :date, GraphQL::Types::ISO8601Date, null: false
      field :id, ID, null: false
      field :merchant_name, String
      field :transaction_category, Types::TransactionCategory::TransactionCategoryType, null: false
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    end
  end
end
