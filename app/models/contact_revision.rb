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
    
    def restore
      self.revisable_deleted_at = nil
      self.revisable_is_current = true
      save
    end
end
