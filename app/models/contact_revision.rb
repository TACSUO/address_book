class ContactRevision < ActiveRecord::Base
  acts_as_revision :revisable_class_name => 'Contact'
  
  extend ContactClassMethods
  include ContactInstanceMethods
  include DeletableInstanceMethods
  
  private
  protected
  public
    def phone_numbers
      phonebook.blank? ? [] : PhoneNumber.find(phonebook.split(','))
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

