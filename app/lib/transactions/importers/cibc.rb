module Transactions
  module Importers
    class Cibc
      def initialize(csv_file:)
        @csv_file = csv_file
      end

      def import
        CSV.foreach(csv_file) do |row|
          Rails.logger.debug row
        end
      end

      private

      attr_reader :csv_file
    end
  end
end
