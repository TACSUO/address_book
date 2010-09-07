require 'spec_helper'

describe PhoneNumberRevisionsController do
  
  describe "GET index" do
    context ":id => integer" do
      it "redirects to the phone number revision show page" do
        get :index, :id => 1
        response.should redirect_to phone_number_revision_path(1)
      end
    end
    context "no :id" do
      it "loads deleted phone_numbers as @deleted_phone_numbers" do
        PhoneNumberRevision.should_receive(:deleted).and_return([mock_phone_number_revision])
        get :index
        assigns[:deleted_phone_numbers].should eql [mock_phone_number_revision]
      end
    end
  end
  
  describe "GET show" do
    it "loads phone number revision as @phone_number_revision from params[:id]" do
      PhoneNumberRevision.should_receive(:find).with("1").and_return(mock_phone_number_revision)
      get :show, :id => 1
      assigns[:phone_number_revision].should eql mock_phone_number_revision
    end
  end
  
  describe "POST restore" do
    before(:each) do
      mock_phone_number_revision({
        :restore => nil
      })
      PhoneNumberRevision.stub(:find).and_return(mock_phone_number_revision)
    end
    it "loads phone number revision as @phone_number_revision" do
      PhoneNumberRevision.should_receive(:find).with("1").and_return(mock_phone_number_revision)
      post :restore, :id => 1
      assigns[:phone_number_revision].should eql mock_phone_number_revision
    end
    it "restores the @phone_number_revision" do
      mock_phone_number_revision.should_receive(:restore)
      post :restore, :id => 1
    end
    context "restore succeeds" do
      before(:each) do
        @phone_number_revision.stub(:restore).and_return(true)
        PhoneNumberRevision.stub(:find).and_return(@phone_number_revision)
      end
      it "sets a flash[:message]" do
        post :restore, :id => 1
        flash[:message].should_not be_nil
      end
      it "redirects to the newly restored phone number show page" do
        post :restore, :id => 1
        response.should redirect_to phone_number_path(@phone_number_revision.id)
      end
    end
    context "restore fails" do
      before(:each) do
        @phone_number_revision.stub(:restore).and_return(false)
        PhoneNumberRevision.stub(:find).and_return(@phone_number_revision)
      end
      it "sets a flash[:error]" do
        post :restore, :id => 1
        flash[:error].should_not be_nil
      end
      it "redirects to the phone number revisions index" do
        post :restore, :id => 1
        response.should redirect_to phone_number_revisions_path
      end
    end
  end
end
