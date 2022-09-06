class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.decimal :amount
      t.date :date
      t.string :description
      t.references :transaction_category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
