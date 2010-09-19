require 'spec_helper'

describe ContactRevision do
  it "loads a collection phone_numbers" do
    contact_revision = ContactRevision.new
    contact_revision.phone_numbers.should be_kind_of Array
  end
  it "scopes deleted entries" do
    contact = Contact.create!({
      :first_name => "yea",
      :last_name => "rails3"
    })
    lost_contact = contact.destroy
    deleted_contact = ContactRevision.deleted
    puts deleted_contact.inspect
    #deleted_contact.first_name.should eql lost_contact.first_name
  end
end

# == Schema Information
#
# Table name: address_book_contacts
#
#  id                         :integer         not null, primary key
#  first_name                 :string(255)
#  last_name                  :string(255)
#  title                      :string(255)
#  email                      :string(255)
#  skype                      :string(255)
#  website                    :string(255)
#  street                     :string(255)
#  city                       :string(255)
#  state                      :string(255)
#  zip                        :string(255)
#  comments                   :text
#  descriptors                :text
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
#  phonebook                  :text
#

