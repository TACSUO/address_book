require 'spec_helper'

describe ContactRevision do
  it "loads a collection phone_numbers" do
    contact_revision = ContactRevision.new
    contact_revision.phone_numbers.should be_kind_of Array
  end
end
