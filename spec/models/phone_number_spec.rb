require 'spec_helper'

describe PhoneNumber do
  it "has and belongs to many contacts" do
    phone = PhoneNumber.new
    phone.should respond_to :contacts
    phone.contacts.respond_to?(:build).should be_true
  end
  
  it "provides a list of possible labels" do
    PhoneNumber.label_options.should be_kind_of Array
    PhoneNumber.label_options.should_not be_empty
  end
  
  it "should create a new revision when its reverse_phonebook is updated" do
    phone = PhoneNumber.create!({
      :label => "Cell",
      :number => 1234567890
    })
    contact = Contact.create!({
      :first_name => "Some",
      :last_name => "One"
    })
    phone.revision_number.should eql 0
    phone.contacts << contact
    phone.update_reverse_phonebook
    phone.revision_number.should eql 1
  end
  
  it "should create a new revision when a phone number is updated" do
    phone = PhoneNumber.create!({
      :label => "Cell",
      :number => "(123) 456-7890"
    })
    phone.number = "(098) 765-4321"
    phone.revision_number.should eql 0
    phone.save
    phone.revision_number.should eql 1
  end
end
