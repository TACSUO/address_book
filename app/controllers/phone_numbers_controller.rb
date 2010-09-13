class PhoneNumbersController < AddressBookController

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
        @contacts = Contact.find(:all)
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
      if @contact
        save = @contact.add_phone_number(params[:phone_number])
        if save
          return_path = contact_path(@contact)
        end
      else
        @phone_number = PhoneNumber.new(params[:phone_number])
        @phone_number.update_reverse_phonebook
        save = @phone_number.save
        if save
          @phone_number.contacts.each do |contact|
            contact.update_phonebook
            contact.save
          end
          return_path = phone_number_path(@phone_number)
        end
      end
      if save
        flash[:notice] = "Phone number successfully created!"
        redirect_to return_path
      else
        if @contact
          @form_url = contact_phone_numbers_path(@contact)
        else
          @contacts = Contact.find(:all)
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