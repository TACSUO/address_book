require "address_book"
require "rails"

module AddressBook
  class Engine < Rails::Engine
    ASSET_PREFIX = "address_book"
    ENGINEER_VERSION = "0.2.3"

    initializer "address_book.require_dependencies" do
      require 'bundler'
      gemfile = Bundler::Definition.build(root.join('Gemfile'), root.join('Gemfile.lock'), {})
      specs = gemfile.dependencies.select do |d|
        d.name != 'engineer' and (d.groups & [:default, :production]).any?
      end

      specs.collect { |s| s.autorequire || [s.name] }.flatten.each do |r|
        require r
      end
    end

    initializer "address_book.action_view.identifier_collection" do
      require 'address_book/action_view'
    end

    initializer "address_book.asset_path" do
      require 'address_book/asset_path'
      setup_asset_path
    end
  end
end
