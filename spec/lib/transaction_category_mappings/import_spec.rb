RSpec.describe TransactionCategoryMappings::Import do
  subject(:import) { described_class.new(csv_file:).import }

  let(:csv_file) { Rails.root.join('spec/fixtures/files/transaction_category_mappings.csv') }

  describe '#import' do
    it 'imports the mappings' do
      expect { import }.to change(TransactionCategoryMapping, :count).by(4)
    end

    it 'creates transaction category if needed' do
      expect { import }.to change(TransactionCategory, :count).by(2)
    end
  end
end
