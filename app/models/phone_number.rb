class PhoneNumber < ActiveRecord::Base
  cattr_reader :label_options

  @@label_options = %w(Office Cell Home Fax)
  
  set_table_name "address_book_phone_numbers"
  
  has_and_belongs_to_many :contact, {
    :join_table => 'address_book_contacts_phone_numbers'
  }
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

