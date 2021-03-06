# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
require 'rake'

AddressBook::Application.load_tasks

excluded_files = %w(config/database.yml)

Engineer::Tasks.new do |gem|
  gem.name = "address_book"
  gem.summary = %Q{Simple versioned contact management for Rails 3.}
  gem.description = %Q{Provides basic contact management features with versioned history of changes.}
  gem.email = ["jason.lapier@gmail.com", "jeremiah@inertialbit.net"]
  gem.homepage = "http://github.com/inertialbit/address_book"
  gem.authors = ["Jason LaPier", "Jeremiah Heller"]
  gem.require_path = 'lib'
  gem.files =  FileList[
    "[A-Z]*",
    "{app,config,lib,public,vendor,spec,test}/**/*",
    "db/**/*.rb"
  ]
  
  excluded_files.each{|f| gem.files.exclude(f)}

  # Include Bundler dependencies
  Bundler.definition.dependencies.each do |dependency|
    next if dependency.name == "engineer"

    if (dependency.groups & [:default, :production]).any?
      gem.add_dependency dependency.name, *dependency.requirement.as_list
    else
      gem.add_development_dependency dependency.name, *dependency.requirement.as_list
    end
  end

  # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
end
