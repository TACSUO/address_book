class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :address_book
  
  private
    def address_book
      if defined?(AbstractGroup::Engine)
        super
      else
        return self
      end
    end
  protected
  public
end
