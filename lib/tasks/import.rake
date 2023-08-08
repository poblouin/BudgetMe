namespace :import do
  task :tangerine, [:csv_file] => :environment do |_, args|
    Transactions::Import.new(bank: :tangerine, csv_file: args.fetch(:csv_file)).import
  end

  task :cibc, [:csv_file] => :environment do |_, args|
    Transactions::Import.new(bank: :cibc, csv_file: args.fetch(:csv_file)).import
  end

  task :mappings, [:csv_file] => :environment do |_, args|
    TransactionCategoryMappings::Import.new(csv_file: args.fetch(:csv_file)).import
  end
end
