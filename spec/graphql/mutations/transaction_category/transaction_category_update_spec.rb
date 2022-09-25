RSpec.describe Mutations::TransactionCategory::TransactionCategoryUpdate do
  let(:transaction_category) { create(:transaction_category) }
  let(:result) { BudgetmeSchema.execute(query) }

  describe 'success' do
    let(:query) do
      <<~GQL
        mutation {
          transactionCategoryUpdate(
            input: {
              id: #{transaction_category.id}
              params: { name: "NewName" }
            }) {
            transactionCategory {
              id,
              name
            }
          }
        }
      GQL
    end
    let(:return_obj) { result.to_h['data']['transactionCategoryUpdate']['transactionCategory'] }

    it 'updates the transaction category' do
      pp return_obj
      expect(return_obj).not_to be_nil
    end

    it 'updates the transaction category with the proper value' do
      expect(return_obj.fetch('name')).to eq('NewName')
    end
  end

  describe 'failure' do
    context 'when the name is missing' do
      let(:error) { result.to_h['errors'].first }
      let(:query) do
        <<~GQL
          mutation {
            transactionCategoryUpdate(
              input: {
                id: #{transaction_category.id},
                params: { noName: "" }
              }) {
              transactionCategory {
                id
              }
            }
          }
        GQL
      end

      it 'does not find such object' do
        expect(error.fetch('message')).to eq("Argument 'name' on InputObject 'TransactionCategoryInput' is required. Expected type String!")
      end
    end

    context 'when the transaction category does not exist' do
      let(:query) do
        <<~GQL
          mutation {
            transactionCategoryUpdate(
              input: {
                id: 99,
                params: { name: "NewName" }
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
end
