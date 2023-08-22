RSpec.describe Mutations::Transaction::TransactionUpdate do
  let(:transaction) { create(:transaction) }
  let(:result) { BudgetmeSchema.execute(query) }

  describe 'success' do
    let(:return_obj) { result.to_h.dig('data', 'transactionUpdate', 'transaction') }

    context 'when updating the amount' do
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

      it 'updates the transaction' do
        expect(return_obj).not_to be_nil
      end

      it 'updates the transaction with the correct value' do
        expect(return_obj.fetch('amount')).to eq(19.99)
      end
    end

    context 'when updating the transaction category' do
      let(:query) do
        <<~GQL
          mutation {
            transactionUpdate(
              input: {
                id: #{transaction.id}
                params: { transactionCategoryId: #{transaction_category.id} }
              }) {
              transaction {
                id,
                amount,
                transactionCategory {
                  id,
                }
              }
            }
          }
        GQL
      end

      let(:transaction_category) { create(:transaction_category) }
      let!(:mapping) { create(:transaction_category_mapping, merchant_name: transaction.merchant_name, transaction_category: transaction.transaction_category) }

      it 'updates the transaction' do
        expect(return_obj).not_to be_nil
      end

      it 'updates the transaction with the correct value' do
        expect(return_obj.fetch('transactionCategory').fetch('id').to_i).to eq(transaction_category.id)
      end

      it 'updates the mapping' do
        result

        expect(mapping.reload.transaction_category).to eq(transaction_category)
      end
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
