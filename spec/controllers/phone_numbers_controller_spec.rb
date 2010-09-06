require 'spec_helper'

describe PhoneNumbersController do
  before(:each) do
    mock_contact(:add_phone_number => nil)
    @new_phone_number = mock_model(PhoneNumber).as_new_record
    @contact.stub_chain(:phone_numbers, :build).and_return(@new_phone_number)
    Contact.stub(:find).and_return(@contact)
  end
  
  describe "GET index, :contact_id => integer" do
    it "redirects to contacts index page if no contact found" do
      contact_not_found{ get :index, :contact_id => 1 }
    end
    it "loads a contact as @contact" do
      load_contact{ get :index, :contact_id => 1 }
    end
  end
  
  describe "GET new, :contact_id => integer" do
    it "redirects to contacts index page if no contact found" do
      contact_not_found{ get :new, :contact_id => 1 }
    end
    it "loads a contact as @contact" do
      load_contact{ get :new, :contact_id => 1 }
    end
    it "instantiates a new phone number as @phone_number" do
      get :new, :contact_id => 1
      assigns[:phone_number].should eql @new_phone_number
    end
  end
  
  describe "POST create, :contact_id => integer, :phone_number => {}" do
    it "redirects to contacts index page if no contact found" do
      contact_not_found{ post :create, :contact_id => 1 }
    end
    it "loads a contact as @contact" do
      load_contact{ post :create, :contact_id => 1 }
    end
    it "saves the new phone number" do
      @contact.should_receive(:add_phone_number)
      post :create, :contact_id => 1
    end
    context "save succeeds :)" do
      before(:each) do
        @contact.stub(:add_phone_number).and_return(true)
      end
      it "sets a flash[:message]" do
        post :create, :contact_id => 1
        flash[:message].should_not be_nil
      end
      it "redirects to the contact show page" do
        post :create, :contact_id => 1
        response.should redirect_to contact_path(@contact)
      end
    end
    context "save fails :(" do
      before(:each) do
        @contact.stub(:add_phone_number).and_return(false)
      end
      it "renders the new template" do
        post :create, :contact_id => 1
        response.should render_template("phone_numbers/new")
      end
    end
  end
end
