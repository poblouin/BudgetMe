class AddTransactionCategoryMapping < ActiveRecord::Migration[7.0]
  def change
    add_index(
      :transaction_category_mappings,
      %i[merchant_name transaction_category_id],
      unique: true,
      name: 'index__merchant_name_and_transaction_category_id'
    )
  end
end
