require 'spec_helper'
require 'acts_as_fu'
RSpec.configure do |config|
  config.include ActsAsFu
end

describe ContactClassMethods do
  describe "distinct attribute finders" do
    before(:each) do
      build_model :fake_contact do
        ActiveRecord::Base.establish_connection(ActiveRecord::Base.configurations[Rails.env.to_sym])
        string :first_name
        string :state
        
        extend ContactClassMethods
      end
      FakeContact.create! :first_name => "blanky"
      FakeContact.create! :state => "NY"
      FakeContact.create! :state => "NY"
      FakeContact.create! :state => "OR"
      FakeContact.create! :state => ""
    end

    it "should find states" do
      FakeContact.existing_states.should == ["NY", "OR"]
    end
  end
  
  describe "attribute collections grouped by type" do
    before(:each) do
      build_model :fake_contact do
        ActiveRecord::Base.establish_connection(ActiveRecord::Base.configurations[Rails.env.to_sym])
        string :first_name
        string :state
        
        extend ContactClassMethods
      end
    end
    it "has string attributes" do
      FakeContact.should respond_to(:string_attributes)
      FakeContact.string_attributes.kind_of?(Array).should be_true
    end
    it "has link attributes" do
      FakeContact.should respond_to(:link_attributes)
      FakeContact.link_attributes.kind_of?(Array).should be_true
    end
    it "has text attributes" do
      FakeContact.should respond_to(:text_attributes)
      FakeContact.text_attributes.kind_of?(Array).should be_true
    end
    it "has datetime attributes" do
      FakeContact.should respond_to(:datetime_attributes)
      FakeContact.datetime_attributes.kind_of?(Array).should be_true
    end
  end
end
