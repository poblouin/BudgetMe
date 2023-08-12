category = TransactionCategory.create!(name: 'Grocery')

Transaction.create!(
  [
    {
      amount: BigDecimal('10.99'),
      date: Date.new(2022, 9, 5),
      merchant_name: 'New transaction',
      transaction_category_id: category.id
    },
    {
      amount: BigDecimal('1000.99'),
      date: Date.new(2022, 9, 4),
      merchant_name: 'New large transaction',
      transaction_category_id: category.id
    }
  ]
)
