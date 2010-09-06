require 'spec_helper'

describe ContactRevisionsController do
  
  describe "GET index" do
    context ":id => integer" do
      it "redirects to the contact revision show page" do
        get :index, :id => 1
        response.should redirect_to contact_revision_path(1)
      end
    end
    context "no :id" do
      it "loads deleted contacts as @deleted_contacts" do
        ContactRevision.should_receive(:deleted).and_return([mock_contact_revision])
        get :index
        assigns[:deleted_contacts].should eql [mock_contact_revision]
      end
    end
  end
  
  describe "GET show" do
    it "loads contact revision as @contact_revision from params[:id]" do
      ContactRevision.should_receive(:find).with("1").and_return(mock_contact_revision)
      get :show, :id => 1
      assigns[:contact_revision].should eql mock_contact_revision
    end
  end
  
  describe "POST restore" do
    before(:each) do
      mock_contact_revision({
        :restore => nil
      })
      ContactRevision.stub(:find).and_return(mock_contact_revision)
    end
    it "loads contact revision as @contact_revision" do
      ContactRevision.should_receive(:find).with("1").and_return(mock_contact_revision)
      post :restore, :id => 1
      assigns[:contact_revision].should eql mock_contact_revision
    end
    it "restores the @contact_revision" do
      mock_contact_revision.should_receive(:restore)
      post :restore, :id => 1
    end
    context "restore succeeds" do
      before(:each) do
        @contact_revision.stub(:restore).and_return(true)
        ContactRevision.stub(:find).and_return(@contact_revision)
      end
      it "sets a flash[:message]" do
        post :restore, :id => 1
        flash[:message].should_not be_nil
      end
      it "redirects to the newly restored contact show page" do
        post :restore, :id => 1
        response.should redirect_to contact_path(@contact_revision.id)
      end
    end
    context "restore fails" do
      before(:each) do
        @contact_revision.stub(:restore).and_return(false)
        ContactRevision.stub(:find).and_return(@contact_revision)
      end
      it "sets a flash[:error]" do
        post :restore, :id => 1
        flash[:error].should_not be_nil
      end
      it "redirects to the contact revisions index" do
        post :restore, :id => 1
        response.should redirect_to contact_revisions_path
      end
    end
  end
end
