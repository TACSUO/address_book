class AddPhoneBookToContacts < ActiveRecord::Migration
  def self.up
    add_column :address_book_contacts, :phonebook, :text
  end

  def self.down
    remove_column :address_book_contacts, :phonebook
  end
end
