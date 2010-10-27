module AddressBook::ApplicationHelper
  def link_wrapper(path, wrapper_options={}, link_options={})
    tag       = wrapper_options.delete(:tag) || :p
    link_text = link_options.delete(:link_text) || path
    highlight = wrapper_options.delete(:highlight)
  
    unless path.blank?
      if current_page?(path) && (highlight.nil? || highlight)
        wrapper_options = {:class => (wrapper_options[:class] || '') + " nav_highlight"}
      end
    end
  
    content_tag(tag, wrapper_options) do
      link_to(link_text, path, link_options)
    end
  end

  def link_to_contacts
    link_wrapper(address_book.contacts_path, {}, {
      :link_text => "Full list of Contacts (#{Contact.count})"
    })
  end

  def link_to_deleted_contacts
    link_wrapper(address_book.contact_revisions_path, {}, {
      :link_text => "Deleted Contacts (#{ContactRevision.deleted.count})"
    })
  end

  def link_to_new_contact
    link_wrapper(address_book.new_contact_path, {}, {
      :link_text => "Create New Contact"
    })
  end

  def link_to_contact(contact)
    link_wrapper(address_book.contact_path(contact), {}, {
      :link_text => "Contact Details"
    })
  end

  def link_to_edit_contact(contact)
    link_wrapper(address_book.edit_contact_path(contact), {}, {
      :link_text => "Edit Contact Details"
    })
  end

  def form_for_browse_contact_revisions(contact)
    render :partial => 'contacts/browse_contact_revisions', :locals => {
      :contact => contact
    }
  end

  def form_for_search_contacts
    render :partial => 'contacts/search'
  end

  def link_to_phone_numbers
    link_wrapper(address_book.phone_numbers_path, {}, {
      :link_text => "Full list of Phone Numbers (#{PhoneNumber.count})"
    })
  end

  def link_to_deleted_phone_numbers
    link_wrapper(address_book.phone_number_revisions_path, {}, {
      :link_text => "Deleted Phone Numbers (#{PhoneNumberRevision.deleted.count})"
    })
  end

  def link_to_new_phone_number
    link_wrapper(address_book.new_phone_number_path, {}, {
      :link_text => "Create New Phone Number"
    })
  end

  def link_to_new_contact_phone_number(contact)
    link_wrapper(address_book.new_contact_phone_number_path(contact), {}, {
      :link_text => "Add Phone Number"
    })
  end

  def form_for_browse_phone_number_revisions(phone_number)
    render :partial => 'phone_numbers/browse_phone_number_revisions', :locals => {
      :phone_number => phone_number
    }
  end
end
