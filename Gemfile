source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/poblouin/#{repo}.git" }

ruby '3.1.2'
gem 'bootsnap', require: false
gem 'graphql', '~> 2.0.13'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rails', '~> 7.0.3', '>= 7.0.3.1'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails', '~> 6.2.0'
  gem 'rspec-rails', '~> 6.0.0.rc1'
  gem 'rubocop', '~> 1.35.1', require: false
  gem 'rubocop-graphql', '~> 0.14.6', require: false
  gem 'rubocop-rails', '~> 2.15.2', require: false
  gem 'rubocop-rspec', '~> 2.12.1', require: false
  gem 'shoulda-matchers', '~> 5.1.0'
end

group :development do
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end
