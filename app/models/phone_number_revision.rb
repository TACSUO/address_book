class PhoneNumberRevision < ActiveRecord::Base
  set_table_name "address_book_phone_numbers"
  
  acts_as_revision :revisable_class_name => 'PhoneNumber'
  
  include DeletableInstanceMethods
  
  def contacts
    reverse_phonebook.blank? ? [] : Contact.find(reverse_phonebook.split(','))
  end
end