class AddReversePhonebookToPhoneNumbers < ActiveRecord::Migration
  def self.up
    add_column :address_book_phone_numbers, :reverse_phonebook, :text
  end

  def self.down
    remove_column :address_book_phone_numbers, :reverse_phonebook
  end
end
