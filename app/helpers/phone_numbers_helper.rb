module PhoneNumbersHelper
  def linked_contacts_for(phone)
    phone.contacts.map{|c| link_to c.name, contact_path(c)}.join("; ")
  end
end