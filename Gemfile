source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/poblouin/#{repo}.git" }

ruby '3.2.2'
gem 'bootsnap', require: false
gem 'graphql'
gem 'pg'
gem 'puma'
gem 'rails'

group :development, :test do
  gem 'factory_bot_rails'
  gem 'pry-byebug'
  gem 'rspec-rails'
  gem 'shoulda-matchers'
end

group :development do
  gem 'brakeman'
  gem 'bundler-audit'
  gem 'graphiql-rails'
  gem 'graphql-schema_comparator'
  gem 'lefthook'
  gem 'rubocop', require: false
  gem 'rubocop-graphql', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
end
