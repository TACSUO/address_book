require 'spec_helper'

describe Contact do
  before(:each) do
    @valid_attributes = {
      :first_name => "Joe", :last_name => "Camel"
    }
  end

  it "should create a new instance given valid attributes" do
    Contact.create!(@valid_attributes)
  end
  
  it "attempts to prepend http(s):// to website if missing protocol" do
    contact = Contact.new(:website => "test.com")
    contact.valid?
    contact.website.should eql "http://test.com"
  end
  
  it "should not leave partial schemes in the uri" do
    contact = Contact.new(:website => "htt://test.com")
    contact.valid?
    contact.website.should eql "http://test.com"
  end
  
  it "uses given port if provided" do
    contact = Contact.new(:website => "http://test.com:81")
    contact.valid?
    contact.website.should eql "http://test.com:81"
  end
  
  it "preserves the https scheme if provided" do
    contact = Contact.new(:website => "https://test.com")
    contact.valid?
    contact.website.should eql "https://test.com"
  end
  
  it "should create a new version when an attribute is updated" do
    pending "revision implementation"
    contact = Contact.create!(@valid_attributes)
    contact.first_name = 'Sally'
    contact.revision_number.should == 0
    contact.save
    contact.revision_number.should == 1
  end
end


# == Schema Information
#
# Table name: address_book_contacts
#
#  id          :integer         not null, primary key
#  first_name  :string(255)
#  last_name   :string(255)
#  title       :string(255)
#  email       :string(255)
#  skype       :string(255)
#  website     :string(255)
#  street      :string(255)
#  city        :string(255)
#  state       :string(255)
#  zip         :string(255)
#  comments    :text
#  descriptors :text
#  created_at  :datetime
#  updated_at  :datetime
#

