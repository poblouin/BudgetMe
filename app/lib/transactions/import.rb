module Transactions
  class Import
    def initialize(bank:, csv_file:)
      @bank = bank
      @csv_file = csv_file
    end

    def import
      ActiveRecord::Base.transaction do
        CSV.foreach(csv_file, headers: headers?) do |row|
          data = parser.parse(row: headers? ? row.fields : row)
          transaction_category = transaction_category(data.fetch(:merchant_name), data.fetch(:category))

          Transaction.create!(
            amount: data.fetch(:amount),
            date: data.fetch(:date),
            merchant_name: data.fetch(:merchant_name),
            transaction_category_id: transaction_category.id
          )
        end
      end
    end

    private

    attr_reader :bank,
                :csv_file

    REPORT_WITH_HEADERS = {
      tangerine: true,
      cibc: false
    }.freeze

    def headers?
      REPORT_WITH_HEADERS.fetch(bank)
    end

    def parser
      @parser ||= case bank
                  when :tangerine
                    Parsers::Tangerine.new
                  when :cibc
                    Parsers::Cibc.new
                  else
                    raise ArgumentError, "Bank #{bank} is not supported"
                  end
    end

    def transaction_category(merchant_name, category)
      mapping = transaction_category_mapping(merchant_name)
      return mapping.transaction_category if mapping.present?

      TransactionCategory.find_or_create_by!(name: category || TransactionCategory::UNCATEGORIZED)
    end

    def transaction_category_mapping(merchant_name)
      TransactionCategoryMapping.find_by(merchant_name:)
    end
  end
end
