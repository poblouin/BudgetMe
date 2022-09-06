class Transaction < ApplicationRecord
  belongs_to :transaction_category, dependent: nil
end
