RSpec.describe Transactions::Import do
  subject(:import) { described_class.new(bank:, csv_file:).import }

  let(:tangerine_csv) { Rails.root.join('spec/fixtures/reports/tangerine.csv') }
  let(:cibc_csv) { Rails.root.join('spec/fixtures/reports/cibc.csv') }

  describe '#import' do
    context 'when bank is tangerine' do
      let(:bank) { :tangerine }
      let(:csv_file) { tangerine_csv }

      it 'parses the report and saves the data to the database' do
        import
      end
    end

    context 'when bank is cibc' do
      let(:bank) { :cibc }
      let(:csv_file) { cibc_csv }

      it 'parses the report and saves the data to the database' do
        import
      end
    end
  end
end
