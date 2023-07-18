RSpec.describe BudgetmeSchema do
  it 'matches the dumped schema' do
    aggregate_failures do
      expect(described_class.to_definition.rstrip).to eq(Rails.root.join('schema.graphql').read.rstrip)
      expect(described_class.to_json.rstrip).to eq(Rails.root.join('schema.json').read.rstrip)
    end
  end
end
