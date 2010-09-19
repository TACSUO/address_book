require 'spec_helper'

describe ContactsController do

  describe "GET index" do
    it "assigns contacts as @contacts" do
      Contact.stub!(:paginate).and_return([mock_contact].paginate)
      get :index
      assigns[:contacts].should == [mock_contact]
    end
  end
  
  describe "GET search" do
    it "assigns contacts as @contacts" do
      pending "implementation"
      Contact.should_receive(:search).and_return([mock_contact])
      get :search
      assigns[:contacts].should eql [mock_contact]
    end
  end

  describe "GET show" do
    it "assigns the requested contact as @contact" do
      Contact.stub!(:find).with("37").and_return(mock_contact)
      get :show, :id => "37"
      assigns[:contact].should equal(mock_contact)
    end
  end

  describe "GET new" do
    it "assigns a new contact as @contact" do
      Contact.stub!(:new).and_return(mock_contact)
      get :new
      assigns[:contact].should equal(mock_contact)
    end
  end

  describe "GET edit" do
    it "assigns the requested contact as @contact" do
      Contact.stub!(:find).with("37").and_return(mock_contact)
      get :edit, :id => "37"
      assigns[:contact].should equal(mock_contact)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "assigns a newly created contact as @contact" do
        Contact.stub!(:new).with({'these' => 'params'}).and_return(mock_contact(:save => true))
        post :create, :contact => {:these => 'params'}
        assigns[:contact].should equal(mock_contact)
      end

      it "redirects to the created contact" do
        Contact.stub!(:new).and_return(mock_contact(:save => true))
        post :create, :contact => {}
        response.should redirect_to(contact_url(mock_contact))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved contact as @contact" do
        Contact.stub!(:new).with({'these' => 'params'}).and_return(mock_contact(:save => false))
        post :create, :contact => {:these => 'params'}
        assigns[:contact].should equal(mock_contact)
      end

      it "re-renders the 'new' template" do
        Contact.stub!(:new).and_return(mock_contact(:save => false))
        post :create, :contact => {}
        response.should render_template('new')
      end
    end
  end

  describe "PUT update" do
    before(:each) do
      Contact.stub(:find).and_return(mock_contact)
    end
    
    describe "with valid params" do
      it "updates the requested contact" do
        Contact.should_receive(:find).with('37').any_number_of_times.and_return(mock_contact)
        mock_contact.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :contact => {:these => 'params'}
      end

      it "assigns the requested contact as @contact" do
        Contact.stub!(:find).and_return(mock_contact(:update_attributes => true))
        put :update, :id => "1"
        assigns[:contact].should equal(mock_contact)
      end

      it "redirects to the contact" do
        mock_contact.stub(:update_attributes).and_return(true)
        put :update, :id => mock_contact.id.to_s
        response.should redirect_to(contact_url(mock_contact))
      end
    end

    describe "with invalid params" do
      it "updates the requested contact" do
        Contact.should_receive(:find).with("37").and_return(mock_contact)
        mock_contact.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :contact => {:these => 'params'}
      end

      it "assigns the contact as @contact" do
        Contact.stub!(:find).and_return(mock_contact(:update_attributes => false))
        put :update, :id => "1"
        assigns[:contact].should equal(mock_contact)
      end

      it "re-renders the 'edit' template" do
        Contact.stub!(:find).and_return(mock_contact(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end
  end

  describe "DELETE destroy" do
    before(:each) do
      Contact.stub(:find).and_return(mock_contact({
        :destroy => true
      }))
    end
    it "destroys the requested contact" do
      Contact.should_receive(:find).with("37").and_return(mock_contact)
      mock_contact.should_receive(:destroy)
      delete :destroy, :id => "37"
    end
    it "sets a flash[:notice]" do
      delete :destroy, :id => 1
      flash[:notice].should_not be_nil
    end
    it "redirects to the contacts list" do
      delete :destroy, :id => "1"
      response.should redirect_to(contacts_url)
    end
  end
end
