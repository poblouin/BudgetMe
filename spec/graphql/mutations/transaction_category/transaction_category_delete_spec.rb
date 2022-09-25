RSpec.describe Mutations::TransactionCategory::TransactionCategoryDelete do
  let(:transaction_category) { create(:transaction_category) }
  let(:query) do
    <<~GQL
      mutation {
        transactionCategoryDelete(
          input: {
            id: #{transaction_category.id}
          }) {
          transactionCategory {
            id
          }
        }
      }
    GQL
  end
  let(:result) { BudgetmeSchema.execute(query) }

  describe 'success' do
    let(:return_obj) { result.to_h['data']['transactionCategoryDelete']['transactionCategory'] }

    it 'deletes the transaction category' do
      expect(return_obj).not_to be_nil
    end

    it 'deletes the proper transaction category' do
      expect(return_obj.fetch('id').to_i).to eq(transaction_category.id)
    end
  end

  describe 'failure' do
    let(:error) { result.to_h['errors'].first }
    let(:query) do
      <<~GQL
        mutation {
          transactionCategoryDelete(
            input: {
              id: 99
            }) {
            transactionCategory {
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
