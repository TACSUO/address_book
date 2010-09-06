class PhoneNumbersController < ApplicationController
  
  before_filter :load_contact
  
  private
    def load_contact
      @contact = Contact.find(params[:contact_id], {
        :include => :phone_numbers
      })
    end
  protected
  public  
    def index
    end
  
    def new
      @phone_number = @contact.phone_numbers.build
    end
    
    def show
      @phone_number = @contact.phone_numbers.find(params[:id])
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
      @phone_number = @contact.phone_numbers.find(params[:id])
    end
    
    def update
      @phone_number = @contact.phone_numbers.find(params[:id])
      if @phone_number.update_attributes(params[:phone_number])
        flash[:notice] = "Successfully updated #{@contact.first_name} #{@contact.last_name}'s phone number!"
        redirect_to contact_path(@contact)
      else
        render :edit
      end
    end
end