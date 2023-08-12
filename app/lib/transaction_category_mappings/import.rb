module TransactionCategoryMappings
  ##
  # Given a csv file with format merchant_name -> transaction_category_name
  # it creates TransactionCategoryMapping in the database
  class Import
    def initialize(csv_file:)
      @csv_file = csv_file
    end

    def import
      CSV.foreach(csv_file, headers: true) do |row|
        transaction_category = transaction_category(row[1])

        TransactionCategoryMapping.find_or_create_by!(
          merchant_name: row[0],
          transaction_category_id: transaction_category.id
        )
      end
    end

    private

    attr_reader :csv_file

    def transaction_category(category)
      TransactionCategory.find_or_create_by!(name: category)
    end
  end
end
