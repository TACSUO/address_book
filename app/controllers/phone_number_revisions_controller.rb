class PhoneNumberRevisionsController < AddressBook::ApplicationController
  
  def index
    if params[:id]
      redirect_to phone_number_revision_path(params[:id])
    else
      @deleted_phone_numbers = PhoneNumberRevision.deleted
    end
  end

  def show
    @phone_number_revision = PhoneNumberRevision.find params[:id]
  end
  
  def restore
    @phone_number_revision = PhoneNumberRevision.find(params[:id])
    if @phone_number_revision.restore
      flash[:message] = "Restored phone number."
      redirect_to(phone_number_path(@phone_number_revision))
    else
      flash[:error] = "There was an error restoring the phone number."
      redirect_to(phone_number_revisions_path)
    end
  end
  
end