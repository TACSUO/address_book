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
  
  it "has and belongs to many phone numbers" do
    contact = Contact.create!(@valid_attributes)
    contact.should respond_to :phone_numbers
    contact.phone_numbers.respond_to?(:build).should be_true
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
    contact = Contact.create!(@valid_attributes)
    contact.first_name = 'Sally'
    contact.revision_number.should eql 0
    contact.save
    contact.revision_number.should eql 1
  end
  
  it "encapsulates adding a phone number and updating both the phonebook and reverse_phonebook" do
    contact = Contact.create!(@valid_attributes)
    contact.add_phone_number(:label => 'Cell', :number => '1234567890')
    contact.phonebook.should eql contact.phone_number_ids.join(',')
    contact.phone_numbers.count.should eql 1
    contact.phone_numbers.first.reverse_phonebook.should eql contact.id.to_s
  end
  
  it "produces a revision when adding a phone number" do
    contact = Contact.create!(@valid_attributes)
    contact.revision_number.should eql 0
    contact.add_phone_number(:label => 'Cell', :number => '1234567890')
    contact.revision_number.should eql 1
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

