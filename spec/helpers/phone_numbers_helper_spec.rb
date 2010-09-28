require 'spec_helper'

describe PhoneNumbersHelper do
  before(:each) do
    helper.stub(:address_book).and_return(helper)
  end
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
      :local_number => "(123) 456-7890",
      :contacts => [contact_one, contact_two]
    })
    links = helper.linked_contacts_for(phone)
    links.should eql "#{link_to contact_one.name, contact_path(contact_one)};"+
                      " #{link_to contact_two.name, contact_path(contact_two)}"
  end
  it "displays a phone number" do
    phone = PhoneNumber.new({
      :label => "Office",
      :local_number => "(123) 456-7890"
    })
    phone.valid?
    phone_number = helper.display_phone_number(phone)
    phone_number.should eql "+1 123 456 7890"
    phone.extension = "4321"
    phone_number = helper.display_phone_number(phone)
    phone_number.should eql "+1 123 456 7890 x 4321"
  end
end
