class ContactRevisionsController < ApplicationController
  def index
    if params[:id]
      redirect_to contact_revision_path(params[:id])
    else
      @deleted_contacts = ContactRevision.deleted
    end
  end

  def show
    @contact_revision = ContactRevision.find params[:id]
  end
  
  def restore
    @contact_revision = ContactRevision.find(params[:id])
    if @contact_revision.restore    
      flash[:notice] = "Contact <em>#{@contact_revision.name}</em> restored."
      redirect_to(contact_path(@contact_revision))
    else
      flash[:error] = "There was an error restoring the contact."
      redirect_to(contact_revisions_path)
    end
  end
end