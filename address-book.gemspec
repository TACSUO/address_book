# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)
 
require 'address-book/version'
require 'bundler'
 
Gem::Specification.new do |s|
  s.name = "address-book"
  s.summary = "Simple versioned contact management for Rails 3."
  s.homepage = "http://github.com/inertialbit/address-book"
  s.description = "Provides basic contact management features with versioned history of changes.

  Can be run either as an Engine or standalone Rails app.

  Use as Engine

  - Setup integration app with edge rails
  - Build & Install address-book gem
  - Update integration app's Gemfile to use the address-book gem
  - Copy migrations & Create symlinks to public
  - Setup database and run migrations

  Rake tasks provided by edge rails:

    FROM=address_book rake railties:copy_migrations
    rake railties:create_symlinks"
  s.version = AddressBook::Version.number
  s.platform = Gem::Platform::RUBY
  s.authors = ["Jason LaPier", "Jeremiah Heller"]
  s.email = ["jason.lapier@gmail.com", "jeremiah@inertialbit.net"]
  s.summary = "Rails 3 Address Book Engine"
  s.files = Dir["Gemfile", "{vendor}/**/*", "{lib}/**/*", "{app}/**/*", "{config}/**/*", "{db}/migrate/**/*", "{db}/seeds.rb", "{public}/images/**/*", "{public}/stylesheets/**/*", "{public}/javascripts/**/*", "{public}/address_book/**/*"]
  s.required_rubygems_version = ">= 1.3.7"

  # thanks http://github.com/phs/engineer
  Bundler.definition.dependencies.each do |dependency|
    if (dependency.groups & [:default, :production]).any?
      s.add_dependency dependency.name, *dependency.requirement.as_list
    else
      s.add_development_dependency dependency.name, *dependency.requirement.as_list
    end
  end
end