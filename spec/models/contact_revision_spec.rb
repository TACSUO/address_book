require 'spec_helper'

describe ContactRevision do  
  it "restores deleted contacts" do
    contact = Contact.create!({
      :first_name => 'test',
      :last_name => 'mcgee'
    })
    Contact.count.should eql 1
    ContactRevision.count.should eql 0
    contact = Contact.find(contact.id)
    contact.destroy
    Contact.count.should eql 0
    ContactRevision.count.should eql 1
    contact_revision = ContactRevision.find(contact.id)
    contact_revision.restore
    Contact.count.should eql 1
    ContactRevision.count.should eql 0
  end
  
  it "loads a collection phone_numbers" do
    contact_revision = ContactRevision.new
    contact_revision.phone_numbers.should be_kind_of Array
  end
end
