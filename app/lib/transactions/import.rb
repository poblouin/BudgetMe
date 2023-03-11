module Transactions
  class Import
    def initialize(bank:, csv_path:)
      @bank = bank
      @csv_path = csv_path
    end

    def import
      importer.new(csv_path:).import
    end

    private

    attr_reader :bank,
                :csv_path

    def importer
      case bank
      when 'tangerine'
        Importers::Tangerine
      else
        raise ArgumentError, "Bank #{bank} is not supported"
      end
    end
  end
end
