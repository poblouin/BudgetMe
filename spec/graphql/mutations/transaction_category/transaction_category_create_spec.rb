RSpec.describe Mutations::TransactionCategory::TransactionCategoryCreate do
  let(:result) { BudgetmeSchema.execute(query) }

  describe 'success' do
    let(:query) do
      <<~GQL
        mutation {
          transactionCategoryCreate(input: { params: { name: "Mortgage" }}) {
            transactionCategory {
              id,
              name
            }
          }
        }
      GQL
    end
    let(:transaction_category) { result.to_h['data']['transactionCategoryCreate']['transactionCategory'] }

    it 'creates a transaction category' do
      expect(transaction_category).not_to be_nil
    end

    it 'has the correct value' do
      expect(transaction_category.fetch('name')).to eq('Mortgage')
    end
  end

  describe 'failure' do
    let(:error) { result.to_h['errors'].first }

    context 'when the name is missing' do
      let(:query) do
        <<~GQL
          mutation {
            transactionCategoryCreate(input: { params: { noName: "" }}) {
              transactionCategory {
                id
              }
            }
          }
        GQL
      end

      it 'returns an error' do
        expect(error['message']).to eq("Argument 'name' on InputObject 'TransactionCategoryInput' is required. Expected type String!")
      end
    end
  end
end
