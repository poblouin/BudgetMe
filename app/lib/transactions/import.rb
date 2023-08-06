module Transactions
  class Import
    def initialize(bank:, csv_file:)
      @bank = bank
      @csv_file = csv_file
    end

    def import
      importer.new(csv_file:).import
    end

    private

    attr_reader :bank,
                :csv_file

    def importer
      case bank
      when :tangerine
        Importers::Tangerine
      when :cibc
        Importers::Cibc
      else
        raise ArgumentError, "Bank #{bank} is not supported"
      end
    end
  end
end
