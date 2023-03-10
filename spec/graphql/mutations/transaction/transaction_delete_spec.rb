RSpec.describe Mutations::Transaction::TransactionDelete do
  let(:transaction) { create(:transaction) }
  let(:query) do
    <<~GQL
      mutation {
        transactionDelete(
          input: {
            id: #{transaction.id}
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
    let(:return_obj) { result.to_h['data']['transactionDelete']['transaction'] }

    it 'deletes the transaction' do
      expect(return_obj).not_to be_nil
    end

    it 'deletes the correct transaction' do
      expect(return_obj.fetch('id').to_i).to eq(transaction.id)
    end
  end

  describe 'failure' do
    let(:error) { result.to_h['errors'].first }
    let(:query) do
      <<~GQL
        mutation {
          transactionDelete(
            input: {
              id: 99
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
