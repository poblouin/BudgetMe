RSpec.describe Mutations::Transaction::TransactionCreate do
  let(:transaction_category) { create(:transaction_category) }
  let(:query) do
    <<~GQL
      mutation {
        transactionCreate(
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
  let(:result) { BudgetmeSchema.execute(query) }

  describe 'success' do
    let(:transaction) { result.to_h['data']['transactionCreate']['transaction'] }

    it 'creates a transaction' do
      expect(transaction).not_to be_nil
    end
  end

  describe 'failure' do
    let(:error) { result.to_h['errors'].first }

    context 'when the amount is missing' do
      let(:query) do
        <<~GQL
          mutation {
            transactionCreate(
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
            transactionCreate(
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
