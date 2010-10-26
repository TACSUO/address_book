require "address_book"
require "rails"

module AddressBook
  class Engine < Rails::Engine
    ASSET_PREFIX = "address_book"
    ENGINEER_VERSION = "0.2.3"

    initializer "address_book.require_dependencies" do
      require 'bundler'
      gemfile = Bundler::Definition.from_gemfile(root.join('Gemfile'))
      specs = gemfile.dependencies.select do |d|
        d.name != 'engineer' and (d.groups & [:default, :production]).any?
      end

      specs.collect { |s| s.autorequire || [s.name] }.flatten.each do |r|
        require r
      end
    end

    initializer "address_book.action_view.identifier_collection" do
      require 'action_view/template'
      class ActionView::Template
        def render_with_identifier_collection(view, locals, &block)
          (Thread.current[:view_identifiers] ||= []).push identifier
          render_without_identifier_collection(view, locals, &block)
        ensure
          Thread.current[:view_identifiers].pop
        end

        unless instance_methods.include? "render_without_identifier_collection"
          alias_method_chain :render, :identifier_collection
        end
      end
    end

    def engine_view?(identifier)
      @engine_views ||= Hash.new do |h, identifier|
        h[identifier] = !Rails.application.paths.app.views.any? do |path|
          identifier =~ /^#{Regexp.escape(path)}/
        end
      end
      @engine_views[identifier]
    end

    initializer "address_book.asset_path" do
      AddressBook::ApplicationController.config.asset_path = lambda do |source|
        view_identifier = (Thread.current[:view_identifiers] ||= []).last
        engine_view?(view_identifier) ? "/#{ASSET_PREFIX}#{source}" : source
      end
    end
  end
end
