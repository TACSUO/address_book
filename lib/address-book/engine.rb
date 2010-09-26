module AddressBook
  class Application < Rails::Engine
    engine_name :address_book
    config.action_controller.asset_path = "/address_book/%s"
    
    config.gem 'formtastic'
    config.gem 'will_paginate', '~> 3.0.pre2', {
      :source => 'http://gemcutter.org'
    }
    config.gem 'acts_as_revisable', '>= 1.1.2'
  end
end