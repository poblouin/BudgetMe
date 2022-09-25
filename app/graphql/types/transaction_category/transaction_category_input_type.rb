module Types
  module TransactionCategory
    class TransactionCategoryInputType < Types::BaseInputObject
      argument :name, String, required: true
    end
  end
end
