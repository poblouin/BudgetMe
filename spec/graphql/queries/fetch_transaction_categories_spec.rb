RSpec.describe Queries::FetchTransactionCategories do
  before { create_list(:transaction_category, 2) }

  describe '#resolve' do
    let(:query) do
      <<~GQL
        query {
          transactionCategories {
            name
          }
        }
      GQL
    end
    let(:result) { BudgetmeSchema.execute(query) }
    let(:transaction_categories) { result.to_h['data']['transactionCategories'] }

    it 'returns transaction categories' do
      expect(transaction_categories.count).to eq(2)
    end
  end
end
