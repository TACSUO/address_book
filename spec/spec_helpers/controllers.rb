def load_contact(options={}, &block)
  Contact.should_receive(:find).and_return(@contact)
  yield
  assigns[:contact].should eql @contact
end
