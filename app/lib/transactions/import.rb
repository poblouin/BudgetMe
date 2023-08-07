module Transactions
  class Import
    def initialize(bank:, csv_file:)
      @bank = bank
      @csv_file = csv_file
    end

    def import
      CSV.foreach(csv_file, headers: headers?) do |row|
        Rails.logger.debug parser.parse(row: headers? ? row.fields : row)
      end
    end

    private

    attr_reader :bank,
                :csv_file

    REPORT_WITH_HEADERS = {
      tangerine: true,
      cibc: false
    }.freeze

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

    def headers?
      REPORT_WITH_HEADERS.fetch(bank)
    end
  end
end
