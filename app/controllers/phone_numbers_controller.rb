class PhoneNumbersController < AddressBook::ApplicationController

  layout "address-book"
  
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
      @phone_number = PhoneNumber.new
      if @contact
        @form_url = contact_phone_numbers_path(@contact)
      else
        @contacts = Contact.all
        @form_url = phone_numbers_path
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
      if params[:phone_number]
        @phone_number = PhoneNumber.first({
          :conditions => {
            :country_code => params[:phone_number][:country_code],
            :extension => params[:phone_number][:extension],
            :local_number => params[:phone_number][:local_number]
          }
        })
      end
      if @phone_number.nil?
        @phone_number = PhoneNumber.new(params[:phone_number])
      end
      
      @phone_number.update_reverse_phonebook
      valid = @phone_number.valid?
      
      if @contact && valid
        unless @contact.add_phone_number(@phone_number)
          flash[:notice] = "Phone number successfully created, however it could"+
                           " not be associated w/ #{@contact.name}"
        end
        return_path = contact_path(@contact)
      elsif valid # possibly many contacts were selected
        @phone_number.contacts.each do |contact|
          contact.update_phonebook
          contact.save
        end
        return_path = phone_number_path(@phone_number)
      end
      
      if valid
        flash[:notice] = "Phone number successfully created!"
        redirect_to return_path
      else
        if @contact
          @form_url = contact_phone_numbers_path(@contact)
        else
          @contacts = Contact.all
          @form_url = phone_numbers_path
        end
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