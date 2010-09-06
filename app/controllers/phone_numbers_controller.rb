class PhoneNumbersController < ApplicationController
  
  before_filter :load_contact
  
  private
    def load_contact
      begin
        @contact = Contact.find(params[:contact_id], {
          :include => :phone_numbers
        })
      rescue ActiveRecord::RecordNotFound
        contact_not_found
      end
    end
    def contact_not_found
      flash[:message] = "Could not locate the contact using id of '#{params[:contact_id]}'."
      redirect_to contacts_path
    end
  protected
  public  
    def index
    end
  
    def new
      @phone_number = @contact.phone_numbers.build
    end
    
    def create
      if @contact.add_phone_number(params[:phone_number])
        flash[:message] = "Phone number successfully added!"
        redirect_to contact_path(@contact)
      else
        render :new
      end
    end
end