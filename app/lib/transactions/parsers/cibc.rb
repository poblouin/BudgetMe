module Transactions
  module Parsers
    ##
    # Parses a row from a Tangerine report
    #
    # Row format: Date,Description,DR,CR,Account Number
    #
    # Note: This class assumes that the report is a credit card report, that means
    # debits are negative and credits are positive.
    class Cibc
      def parse(row:)
        amount = BigDecimal(row[2] || row[3])
        amount = -amount if row[2].present?

        {
          date: Date.parse(row[0]),
          description: row[1],
          category: nil,
          amount:
        }
      end
    end
  end
end
