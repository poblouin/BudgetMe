# frozen_string_literal: true

module Transactions
  module Importers
    class Tangerine
      def initialize(csv_path:)
        @csv_path = csv_path
      end

      def import
        CSV.foreach(csv_path) do |row|
          Rails.logger.debug row
        end
      end

      private

      attr_reader :csv_path
    end
  end
end
