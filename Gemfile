# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby(File.read(File.join(File.dirname(__FILE__), '.ruby-version')).strip)

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 6.1.3', '>= 6.1.3.2'
# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'
# Use Puma as the app server
gem 'puma', '~> 5.0'
# Use Active Model has_secure_password
gem 'bcrypt', '~> 3.1.7'
# Fast JSON:API serializer for Ruby Objects
gem 'jsonapi-serializer', '~> 2.2.0'
# Business transaction DSL
gem 'dry-transaction', '~> 0.13.3'
# Data validation library that provides a powerful DSL for defining schemas and validation rules
gem 'dry-validation', '~> 1.6.0'

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'

group :development, :test do
  # RSpec testing framework
  gem 'rspec', '~> 3.10'
  # RSpec testing framework to Ruby on Rails
  gem 'rspec-rails', '~> 5.0', '>= 5.0.1'
  # Fixtures replacement with a straightforward definition syntax
  gem 'factory_bot_rails', '~> 6.2'
  # Generates fake data
  gem 'faker', '~> 2.18'
  # Adds step-by-step debugging and stack navigation capabilities to pry using byebug
  gem 'pry-byebug', '~> 3.9'
  # Causes rails console to open pry
  gem 'pry-rails', '~> 0.3.9'

  # Code quality
  # Help you increase your application performance by reducing the number of queries it makes
  gem 'bullet', '~> 6.1', '>= 6.1.4'
  # Patch-level verification for bundler
  gem 'bundler-audit', '~> 0.8.0', require: false
  # A static analysis security vulnerability scanner for Ruby on Rails applications
  gem 'brakeman', '~> 5.0', '>= 5.0.1', require: false
  # Code smell detector for Ruby
  gem 'reek', '6.0.4', require: false
  # Make your Rubies go faster with this command line tool
  gem 'fasterer', '~> 0.9.0', require: false
  # A fully configurable and extendable Git hook manager
  gem 'overcommit', '~> 0.57.0', require: false
  # Code metric tool to check the quality of Rails code
  gem 'rails_best_practices', '~> 1.20.1', require: false
  # A Ruby static code analyzer, based on the community Ruby style guide.
  gem 'rubocop', '~> 1.15.0', require: false
  gem 'rubocop-performance', '~> 1.11.3', require: false
  gem 'rubocop-rails', '~> 2.10.1', require: false
  gem 'rubocop-rspec', '~> 2.3.0', require: false
end

group :development do
  gem 'listen', '~> 3.3'
end

group :test do
  # Code coverage for Ruby with a powerful configuration library and automatic merging of coverage across test suites
  gem 'simplecov', '~> 0.21', '>= 0.21.2', require: false
  # Custom SimpleCov formatter to generate a lcov style coverage
  gem 'simplecov-lcov', '~> 0.8', '>= 0.8.0', require: false
  # Validate the JSON returned by your Rails JSON APIs
  gem 'json_matchers', '~> 0.11', '>= 0.11.1', require: 'json_matchers/rspec'
  # Shoulda Matchers provides RSpec- and Minitest-compatible one-liners to test common Rails functionality
  gem 'shoulda-matchers', '~> 4.5', '>= 4.5.1'
  # Inspects files in a git diff and warns on changed methods, classes and blocks which need to be tested
  gem 'undercover', '~> 0.4.3', require: false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
