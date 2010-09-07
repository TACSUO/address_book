class PhoneNumbersController < ApplicationController

  before_filter :load_contact
  
  private
    def load_contact
      if params[:contact_id]
        @contact = Contact.find(params[:contact_id], {
          :include => :phone_numbers
        })
      end
    end
  protected
  public
    def index
      if @contact
        @phone_numbers = @contact.phone_numbers
      else
        @phone_numbers = PhoneNumber.all(:include => :contacts)
      end
    end
  
    def new
      if @contact
        @phone_number = PhoneNumber.new
      else
        flash[:notice] = "Please select a contact for the new phone number."
        redirect_to contacts_path
      end
    end
    
    def show
      if @contact
        @phone_number = @contact.phone_numbers.find(params[:id])
      else
        @phone_number = PhoneNumber.find(params[:id], :include => :contacts)
      end
    end
    
    def create
      if @contact.add_phone_number(params[:phone_number])
        flash[:notice] = "Phone number successfully added!"
        redirect_to contact_path(@contact)
      else
        render :new
      end
    end
    
    def edit
      if @contact
        @phone_number = @contact.phone_numbers.find(params[:id])
      else
        @phone_number = PhoneNumber.find(params[:id], :include => :contacts)
      end
    end
    
    def update
      if @contact
        @phone_number = @contact.phone_numbers.find(params[:id])
      else
        @phone_number = PhoneNumber.find(params[:id], :include => :contacts)
      end
      if @phone_number.update_attributes(params[:phone_number])
        flash[:notice] = "Phone Number successfully updated!"
        redirect_to phone_number_path(@phone_number)
      else
        render :edit
      end
    end
end