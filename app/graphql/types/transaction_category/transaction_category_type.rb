# frozen_string_literal: true

module Types
  module TransactionCategory
    class TransactionCategoryType < Types::BaseObject
      field :created_at, GraphQL::Types::ISO8601DateTime, null: false
      field :id, ID, null: false
      field :name, String, null: false
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    end
  end
end
