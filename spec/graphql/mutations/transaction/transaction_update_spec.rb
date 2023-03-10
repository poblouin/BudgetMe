RSpec.describe Mutations::Transaction::TransactionUpdate do
  let(:transaction) { create(:transaction) }
  let(:result) { BudgetmeSchema.execute(query) }

  describe 'success' do
    let(:query) do
      <<~GQL
        mutation {
          transactionUpdate(
            input: {
              id: #{transaction.id}
              params: { amount: 19.99 }
            }) {
            transaction {
              id,
              amount
            }
          }
        }
      GQL
    end
    let(:return_obj) { result.to_h['data']['transactionUpdate']['transaction'] }

    it 'updates the transaction' do
      pp result
      expect(return_obj).not_to be_nil
    end

    it 'updates the transaction with the proper value' do
      expect(return_obj.fetch('amount')).to eq(19.99)
    end
  end

  describe 'failure' do
    context 'when no valid attribute is present' do
      let(:error) { result.to_h['errors'].first }
      let(:query) do
        <<~GQL
          mutation {
            transactionUpdate(
              input: {
                id: #{transaction.id}
                params: { void: 19.99 }
              }) {
              transaction {
                id
              }
            }
          }
        GQL
      end

      it 'does not find such object' do
        expect(error.fetch('message')).to eq("InputObject 'TransactionUpdate' doesn't accept argument 'void'")
      end
    end

    context 'when the transaction does not exist' do
      let(:query) do
        <<~GQL
          mutation {
            transactionUpdate(
              input: {
                id: 99
                params: { amount: 19.99 }
              }) {
              transaction {
                id
              }
            }
          }
        GQL
      end

      it 'does not find such object' do
        expect { result }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
