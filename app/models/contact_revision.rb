class ContactRevision < ActiveRecord::Base
  acts_as_revision :revisable_class_name => 'Contact'
  
  extend ContactClassMethods
  include ContactInstanceMethods
  
  private
  protected
  public
    def phone_numbers
      phonebook.blank? ? [] : PhoneNumber.find(phonebook.split(','))
    end
end
