class PhoneNumber < ActiveRecord::Base
  cattr_reader :label_options

  @@label_options = %w(Office Cell Home Fax)
  
  set_table_name "address_book_phone_numbers"
  
  acts_as_revisable :revision_class_name => 'PhoneNumberRevision', :on_delete => :revise
  
  has_and_belongs_to_many :contacts, {
    :join_table => 'address_book_contacts_phone_numbers'
  }
  
  validates_uniqueness_of :number
  
  private
  protected
  public
    def update_reverse_phonebook
      changeset! do |phone|
        phone.reverse_phonebook = phone.contact_ids.join(',')
      end
    end
end


# == Schema Information
#
# Table name: address_book_phone_numbers
#
#  id         :integer         not null, primary key
#  number     :string(255)
#  label      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

