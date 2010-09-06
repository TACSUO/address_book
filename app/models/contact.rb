require 'uri'

class Contact < ActiveRecord::Base
  
  set_table_name "address_book_contacts"

  searchable_by :first_name, :last_name, :city, :state, :zip, :email
  
  acts_as_revisable :revision_class_name => 'ContactRevision', :on_delete => :revise
  
  acts_as_stripped :first_name, :last_name, :title, :street, :city, :state, :zip,
    :email, :comments, :descriptors, :created_at, :updated_at

  has_and_belongs_to_many :phone_numbers, {
    :join_table => 'address_book_contacts_phone_numbers'
  }
  
  before_validation :normalize_website

  extend ContactClassMethods
  include ContactInstanceMethods
  
  private
    def normalize_website
      begin
        uri = URI.parse(website)
      rescue URI::InvalidURIError
        self.website = "http://#{website}"
      else
        if (uri.port.blank? || uri.port == 80)
          self.website = "http://#{uri.host}"
        elsif uri.port == 443
          self.website = "https://#{uri.host}"
        end
        self.website += uri.path unless uri.path.blank?
        self.website += "?#{uri.query}" unless uri.query.blank?
      end
    end
    def update_phonebook
      changeset! do |contact|
        contact.phonebook = contact.phone_number_ids.join(',')
        #contact.save
      end
    end
  protected
  public
    def add_phone_number(phone_number_attributes)
      phone_numbers.create(phone_number_attributes)
      update_phonebook
    end
end


# == Schema Information
#
# Table name: address_book_contacts
#
#  id          :integer         not null, primary key
#  first_name  :string(255)
#  last_name   :string(255)
#  title       :string(255)
#  email       :string(255)
#  skype       :string(255)
#  website     :string(255)
#  street      :string(255)
#  city        :string(255)
#  state       :string(255)
#  zip         :string(255)
#  comments    :text
#  descriptors :text
#  created_at  :datetime
#  updated_at  :datetime
#

