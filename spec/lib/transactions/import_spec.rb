RSpec.describe Transactions::Import do
  subject(:import) { described_class.new(bank:, csv_file:).import }

  let(:tangerine_csv) { Rails.root.join('spec/fixtures/files/tangerine.csv') }
  let(:cibc_csv) { Rails.root.join('spec/fixtures/files/cibc.csv') }

  describe '#import' do
    context 'when bank is tangerine' do
      let(:bank) { :tangerine }
      let(:csv_file) { tangerine_csv }

      it 'parses the report and saves the data to the database' do
        expect { import }.to change(Transaction, :count).by(10)
      end

      it 'creates the transactions with the correct attributes' do
        import

        expect(Transaction.first.attributes.except(:id, :created_at, :updated_at).symbolize_keys).to match(
          hash_including(
            date: Date.new(2023, 8, 3),
            amount: BigDecimal('-23.99'),
            merchant_name: 'SOME FOOD',
            transaction_category_id: TransactionCategory.find_by(name: 'Restaurant').id
          )
        )
      end

      it 'creates the associated transaction category' do
        expect { import }.to change(TransactionCategory, :count).by(5)
      end
    end

    context 'when bank is cibc' do
      let(:bank) { :cibc }
      let(:csv_file) { cibc_csv }

      it 'parses the report and saves the data to the database' do
        expect { import }.to change(Transaction, :count).by(10)
      end

      it 'creates the associated transaction category' do
        expect { import }.to change(TransactionCategory, :count).by(1)
      end
    end

    context 'when transaction category mappings are present' do
      let(:bank) { :cibc }
      let(:csv_file) { cibc_csv }

      before do
        create(:transaction_category_mapping, merchant_name: 'AMZ')
        create(:transaction_category_mapping, merchant_name: 'MARCHE')
        create(:transaction_category_mapping, merchant_name: 'WAL-MART')
        create(:transaction_category_mapping, merchant_name: 'SOME RESTAURANT')
        create(:transaction_category_mapping, merchant_name: 'CASHBACK')
        create(:transaction_category_mapping, merchant_name: 'BOOKS')
        create(:transaction_category_mapping, merchant_name: 'COFFEE SHOP')

        import
      end

      it 'populates the transaction_category for every transaction' do
        expect(Transaction.all.all? { |t| !t.transaction_category_id.nil? }).to be(true)
      end
    end
  end
end
