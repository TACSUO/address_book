class AddressBook::ApplicationController < defined?(ApplicationController) ? ApplicationController : ActionController::Base
  protect_from_forgery
  
  include RescueFromNotFound
  
  private
  protected
  public
end
