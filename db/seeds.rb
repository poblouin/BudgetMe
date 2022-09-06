category = TransactionCategory.create!(name: 'Grocery')

Transaction.create!(
  [
    {
      amount: BigDecimal('10.99'),
      date: Date.new(2022, 9, 5),
      description: 'New transaction',
      transaction_category_id: category.id
    },
    {
      amount: BigDecimal('1000.99'),
      date: Date.new(2022, 9, 4),
      description: 'New large transaction',
      transaction_category_id: category.id
    }
  ]
)
