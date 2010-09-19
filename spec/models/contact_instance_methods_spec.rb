require 'spec_helper'
require 'acts_as_fu'
RSpec.configure do |config|
  config.include ActsAsFu
end

describe ContactInstanceMethods do
  before(:each) do
    build_model :fake_contact do
      ActiveRecord::Base.establish_connection(ActiveRecord::Base.configurations[Rails.env.to_sym])
      string :first_name
      string :last_name
      
      include ContactInstanceMethods
    end
    @fake_contact = FakeContact.new({
      :first_name => 'Moniker',
      :last_name => 'Sir'
    })
  end
  it "combines last_name, first_name as name" do
    @fake_contact.name.should == "Sir, Moniker"
  end
  it "aliases name as fullname" do
    @fake_contact.fullname.should == "Sir, Moniker"
  end
end
