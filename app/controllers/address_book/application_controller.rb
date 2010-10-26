class AddressBook::ApplicationController < defined?(ApplicationController) ? ApplicationController : ActionController::Base
  protect_from_forgery

  helper_method :address_book
  
  include RescueFromNotFound
  
  private
    def address_book
      if defined?(AddressBook::Engine)
        super
      else
        return self
      end
    end
  protected
  public
end
