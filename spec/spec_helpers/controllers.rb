def load_contact(options={}, &block)
  Contact.should_receive(:find).and_return(@contact)
  yield
  assigns[:contact].should eql @contact
end


def contact_not_found(&block)
  Contact.stub(:find).and_raise(ActiveRecord::RecordNotFound)
  yield
  flash[:notice].should_not be_nil
  response.should redirect_to contacts_path
end