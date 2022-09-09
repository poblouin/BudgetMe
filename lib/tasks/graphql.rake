require 'graphql/rake_task'
GraphQL::RakeTask.new(schema_name: 'BudgetmeSchema')

namespace :graphql do
  namespace :schema do
    desc 'Validates GraphQL queries against the current schema'
    task idl_new: [:environment] do
      File.write('schema.graphql.new', BudgetmeSchema.to_definition)
    end
  end
end
