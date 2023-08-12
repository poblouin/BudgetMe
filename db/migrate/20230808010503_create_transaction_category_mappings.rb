class CreateTransactionCategoryMappings < ActiveRecord::Migration[7.0]
  def change
    create_table :transaction_category_mappings do |t|
      t.string :merchant_name
      t.references :transaction_category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
