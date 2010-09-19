module PhoneNumbersHelper
  def linked_contacts_for(phone)
    phone.contacts.map{|c| link_to(c.name, contact_path(c))}.join("; ")
  end
  def display_phone_number(phone)
    number_to_phone(phone.local_number, {
      :delimiter => ' ',
      :extension => phone.extension,
      :country_code => phone.country_code
    })
  end
end