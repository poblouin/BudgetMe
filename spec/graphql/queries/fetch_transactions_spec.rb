RSpec.describe Queries::FetchTransactions do
  before { create_list(:transaction, 2) }

  describe '#resolve' do
    let(:query) do
      <<~GQL
        query {
          transactions {
            amount,
            date,
            transactionCategory {
              name
            }
          }
        }
      GQL
    end
    let(:result) { BudgetmeSchema.execute(query) }
    let(:transactions) { result.to_h['data']['transactions'] }

    it 'returns transactions' do
      expect(transactions.count).to eq(2)
    end

    it 'returns the nested transaction_category' do
      expect(transactions.first['transactionCategory']['name']).to eq('Category')
    end
  end
end
