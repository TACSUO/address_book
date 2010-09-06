def mock_contact(stubs={})
  @contact ||= mock_model(Contact, stubs.merge({
    :first_name => "joe", :name => "joe", :update_attributes => nil
  }))
end

def mock_other_contact(stubs={})
  @other_contact ||= mock_model(Contact, stubs.merge({
    :first_name => "john", :name => "john", :update_attributes => nil
  }))
end

def mock_contact_revision(stubs={})
  @contact_revision ||= mock_model(ContactRevision, stubs)
end

def mock_phone_number(stubs={})
  @phone_number ||= mock_model(PhoneNumber, stubs)
end
