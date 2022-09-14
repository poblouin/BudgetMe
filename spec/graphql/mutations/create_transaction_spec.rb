RSpec.describe Mutations::CreateTransaction do
  let(:transaction_category) { create(:transaction_category) }
  let(:query) do
    <<~GQL
      mutation {
        createTransaction(
          input: {
            params: {
              amount: 20.99,
              date: "2022-09-06",
              transactionCategoryId: #{transaction_category.id}
            }
          }) {
          transaction {
            id
          }
        }
      }
    GQL
  end

  describe 'success' do
    let(:result) { BudgetmeSchema.execute(query) }
    let(:transaction) { result.to_h['data']['createTransaction']['transaction'] }

    it 'creates a transaction' do
      expect(transaction).not_to be_nil
    end
  end

  describe 'failure' do
    let(:result) { BudgetmeSchema.execute(query) }
    let(:error) { result.to_h['errors'].first }

    context 'when the amount is missing' do
      let(:query) do
        <<~GQL
          mutation {
            createTransaction(
              input: {
                params: {
                  date: "2022-09-06",
                  transactionCategoryId: #{transaction_category.id}
                }
              }) {
              transaction {
                id
              }
            }
          }
        GQL
      end

      it 'returns an error' do
        expect(error['message']).to eq("Argument 'amount' on InputObject 'TransactionInput' is required. Expected type Float!")
      end
    end

    context 'when the transaction category is missing' do
      let(:query) do
        <<~GQL
          mutation {
            createTransaction(
              input: {
                params: {
                  amount: 10.99,
                  date: "2022-09-06",
                }
              }) {
              transaction {
                id
              }
            }
          }
        GQL
      end

      it 'returns an error' do
        expect(error['message']).to eq("Argument 'transactionCategoryId' on InputObject 'TransactionInput' is required. Expected type ID!")
      end
    end
  end
end
