class RenameColumnTransactionDescription < ActiveRecord::Migration[7.0]
  def change
    rename_column :transactions, :description, :merchant_name
  end
end
