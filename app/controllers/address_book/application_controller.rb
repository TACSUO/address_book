class AddressBook::ApplicationController < ApplicationController
  protect_from_forgery
  
  prepend_before_filter :use_engine_assets if Rails.env != 'production'
  prepend_before_filter :setup_asset_path if defined?(AddressBook::Engine)
  
  include RescueFromNotFound
  
  private
    def use_engine_assets
      require 'address_book/action_view'
    end
    def setup_asset_path
      config.asset_path = '/address_book%s'
    end
  protected
  public
end
