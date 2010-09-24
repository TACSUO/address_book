# Edit this Gemfile to bundle your application's dependencies.
# This preamble is the current preamble for Rails 3 apps; edit as needed.
source 'http://rubygems.org'
source 'http://gemcutter.org'

gem 'rails', '>= 3.0.0'
gem 'sqlite3-ruby', :require => 'sqlite3'
gem 'will_paginate', '~> 3.0.pre2'
gem 'formtastic'
gem 'acts_as_revisable', {
  :git => "git://github.com/inertialbit/acts_as_revisable.git",
  :branch => 'rails3'
}

group :development, :test do
  gem "rspec-rails", ">= 2.0.0.beta.22"
  gem 'cucumber-rails'
  gem 'capybara'
  gem 'acts_as_fu'
end