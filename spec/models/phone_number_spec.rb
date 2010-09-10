require 'spec_helper'

describe PhoneNumber do
  
  context "valid instance" do
    before(:each) do
      @phone = PhoneNumber.new({
        :label => "Cell",
        :country_code => "+1",
        :local_number => "(123) 456-7890"
      })
    end
    it "is valid with valid attributes" do
      @phone.should be_valid
    end
    it "has a label" do
      @phone.label = nil
      @phone.should_not be_valid
      @phone.should have(1).errors_on(:label)
    end
    it "has a country code" do
      @phone.country_code = nil
      @phone.should_not be_valid
      @phone.should have_at_least(1).errors_on(:country_code)
    end
    it "has a local number" do
      @phone.local_number = nil
      @phone.should_not be_valid
      @phone.should have_at_least(1).errors_on(:local_number)
    end
    it "has a unique local number for a given country code/extension combination" do
      @val_attr = {
        :label => "Office",
        :local_number => "(123) 456-7890",
        :country_code => "23",
        :extension => "432"
      }
      phone_one = PhoneNumber.create!(@val_attr)
      
      phone_two = PhoneNumber.new(@val_attr)
      phone_two.should_not be_valid
      
      phone_two = PhoneNumber.new(@val_attr.merge!({
        :country_code => "22"
      }))
      phone_two.should be_valid
      
      phone_two = PhoneNumber.new(@val_attr.merge!({
        :extension => "433"
      }))
      phone_two.should be_valid
    end
    it "requires 1 digit but no more than 8 for a country_code" do
      @phone.country_code = "a"
      @phone.should have_at_least(1).errors_on(:country_code)
      @phone.country_code = "123456789"
      @phone.should have_at_least(1).errors_on(:country_code)
      @phone.country_code = "1234-5678"
      @phone.should be_valid
    end
    it "requires 7 digits but no more than 14 for a local_number" do
      @phone.local_number = "a"
      @phone.should have_at_least(1).errors_on(:local_number)
      @phone.local_number = "123456"
      @phone.should have_at_least(1).errors_on(:local_number)
      @phone.local_number = "123456789012345"
      @phone.should have_at_least(1).errors_on(:local_number)
    end
  end
  
  describe "normalization" do
    before(:each) do
      @valid_attr = {
        :label => "Office",
        :country_code => "+20",
        :local_number => "(123) 456-7890",
        :extension => "ext. 4567"
      }
      @phone = PhoneNumber.new(@valid_attr)
      @phone.should be_valid
    end
    it "strips non-digit characters from country_code" do
      @phone.country_code.should eql "20"
    end
    it "strips non-digit characters from local_number" do
      @phone.local_number.should eql "1234567890"
    end
    it "strips non-digit characters from extension" do
      @phone.extension.should eql "4567"
    end
  end
  
  it "has and belongs to many contacts" do
    phone = PhoneNumber.new
    phone.should respond_to :contacts
    phone.contacts.respond_to?(:build).should be_true
  end
  
  it "provides a list of possible labels" do
    PhoneNumber.label_options.should be_kind_of Array
    PhoneNumber.label_options.should_not be_empty
  end
  
  it "has a number attribute composed of an instance of TelephoneNumber" do
    phone = PhoneNumber.new({
      :label => "Cell",
      :country_code => "+23",
      :local_number => "(123) 456-7890"
    })
    phone.number.should be_instance_of TelephoneNumber
  end
  
  it "can compare two TelephoneNumber instances with accuracy" do
    phone_one = PhoneNumber.new({
      :label => "Cell",
      :country_code => "+23",
      :local_number => "(123) 654-7890"
    })
    phone_two = PhoneNumber.new({
      :label => "Office",
      :country_code => "+23",
      :local_number => "(123) 654-7890"
    })
    phone_one.number.should == phone_two.number
    phone_one = PhoneNumber.new({
      :label => "Cell",
      :country_code => "+21",
      :local_number => "(123) 654-7890"
    })
    phone_one.number.should_not == phone_two.number
  end
  
  it "should create a new revision when its reverse_phonebook is updated" do
    phone = PhoneNumber.create!({
      :label => "Cell",
      :country_code => "1",
      :local_number => "1234567890"
    })
    contact = Contact.create!({
      :first_name => "Some",
      :last_name => "One"
    })
    phone.revision_number.should eql 0
    phone.contacts << contact
    phone.update_reverse_phonebook
    phone.save
    phone.revision_number.should eql 1
  end
  
  it "should create a new revision when a phone number is updated" do
    phone = PhoneNumber.create!({
      :label => "Cell",
      :country_code => "20",
      :local_number => "(123) 456-7890"
    })
    phone.local_number = "(098) 765-4321"
    phone.revision_number.should eql 0
    phone.save
    phone.revision_number.should eql 1
  end
end



# == Schema Information
#
# Table name: address_book_phone_numbers
#
#  id                         :integer         not null, primary key
#  country_code               :string(15)      default("1")
#  local_number               :string(15)
#  extension                  :string(15)
#  label                      :string(31)
#  created_at                 :datetime
#  updated_at                 :datetime
#  revisable_original_id      :integer
#  revisable_branched_from_id :integer
#  revisable_number           :integer         default(0)
#  revisable_name             :string(255)
#  revisable_type             :string(255)
#  revisable_current_at       :datetime
#  revisable_revised_at       :datetime
#  revisable_deleted_at       :datetime
#  revisable_is_current       :boolean         default(TRUE)
#  reverse_phonebook          :text
#

