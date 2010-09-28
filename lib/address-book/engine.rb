module AddressBook
  class Engine < ::Rails::Engine
    engine_name :address_book
    config.asset_path = "/address_book%s"
    config.action_view.javascript_expansions[:address_book] = %w(jquery-1.4.1.min.js rails.js jquery.tablesorter.min.js jquery-ui-1.7.2.custom.min.js jquery.string.1.0-min.js jquery.clonePosition.js lowpro.jquery.js jquery.qtip-1.0.0-rc3.js behaviors.js)
    config.gem 'formtastic'
    config.gem 'will_paginate', '~> 3.0.pre2', {
      :source => 'http://gemcutter.org'
    }
    config.gem 'acts_as_revisable', '>= 1.1.2'
  end

  mattr_reader :app_type
  @@app_type = AddressBook::Engine
end