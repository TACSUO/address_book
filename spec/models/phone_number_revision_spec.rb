require 'spec_helper'

describe PhoneNumberRevision do
  it "loads a collection of contacts" do
    phone_number_revision = PhoneNumberRevision.new
    phone_number_revision.contacts.should be_kind_of Array
  end
end
