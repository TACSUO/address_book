class PhoneNumberRevision < ActiveRecord::Base
  set_table_name "address_book_phone_numbers"
  
  acts_as_revision :revisable_class_name => 'PhoneNumber'
  
  include DeletableInstanceMethods
  
  def contacts
    reverse_phonebook.blank? ? [] : Contact.find(reverse_phonebook.split(','))
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

