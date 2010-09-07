require 'spec_helper'

describe PhoneNumbersHelper do
  it "creates a list of linked contact names" do
    contact_one = Contact.create!({
      :first_name => "Some",
      :last_name => "One"
    })
    contact_two = Contact.create!({
      :first_name => "No",
      :last_name => "One"
    })
    phone = PhoneNumber.create!({
      :label => "Cell",
      :number => "(123) 456-7890",
      :contacts => [contact_one, contact_two]
    })
    links = helper.linked_contacts_for(phone)
    links.should eql "#{link_to contact_one.name, contact_path(contact_one)};"+
                      " #{link_to contact_two.name, contact_path(contact_two)}"
  end
end
