source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/poblouin/#{repo}.git" }

ruby '3.2.1'
gem 'bootsnap', require: false
gem 'graphql', '~> 2.0.18'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rails', '~> 7.0.4', '>= 7.0.4.3'

group :development, :test do
  gem 'factory_bot_rails', '~> 6.2.0'
  gem 'pry-byebug', '~> 3.10.1'
  gem 'rspec-rails', '~> 6.0.1'
  gem 'shoulda-matchers', '~> 5.1.0'
end

group :development do
  gem 'brakeman', '~> 5.3.1'
  gem 'bundler-audit', '~> 0.9.1'
  gem 'graphiql-rails', '~> 1.8.0'
  gem 'graphql-schema_comparator', '~>1.1.1'
  gem 'lefthook', '~> 1.1.1'
  gem 'rubocop', '~> 1.35.1', require: false
  gem 'rubocop-graphql', '~> 0.14.6', require: false
  gem 'rubocop-rails', '~> 2.15.2', require: false
  gem 'rubocop-rspec', '~> 2.12.1', require: false
end
