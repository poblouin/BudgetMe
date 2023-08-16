RSpec.describe Queries::FetchTransactions do
  let(:date_now) { Time.zone.today }

  before { create_list(:transaction, 2) }

  describe '#resolve' do
    let(:query) do
      <<~GQL
        query {
          transactions {
            amount,
            date,
            transactionCategory {
              name
            }
          }
        }
      GQL
    end
    let(:result) { BudgetmeSchema.execute(query) }
    let(:transactions) { result.to_h['data']['transactions'] }

    it 'returns transactions' do
      expect(transactions.count).to eq(2)
    end

    it 'returns the nested transaction_category' do
      expect(transactions.first['transactionCategory']['name']).to eq('Category')
    end

    context 'when a range is requested' do
      context 'when only from is provided' do
        let(:query_from) { (date_now + 2).to_s }
        let(:query) do
          <<~GQL
            query {
              transactions(from: "#{query_from}") {
                amount,
                date,
                transactionCategory {
                  name
                }
              }
            }
          GQL
        end

        before { create_list(:transaction, 2, date: date_now + 2) }

        it 'returns transactions' do
          expect(transactions.count).to eq(2)
        end
      end

      context 'when from and to are provided' do
        let(:query_from) { date_now.to_s }
        let(:query_to) { (date_now + 2).to_s }
        let(:query) do
          <<~GQL
            query {
              transactions(from: "#{query_from}", to: "#{query_to}") {
                amount,
                date,
                transactionCategory {
                  name
                }
              }
            }
          GQL
        end

        before do
          create_list(:transaction, 2, date: query_from.to_date - 2)
          create_list(:transaction, 2, date: query_to.to_date + 2)
        end

        it 'returns transactions' do
          expect(transactions.count).to eq(2)
        end
      end
    end
  end
end
