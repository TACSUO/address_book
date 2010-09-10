class AddIndexOnPhoneNumberCountryCodeExtension < ActiveRecord::Migration
  def self.up
    add_index :address_book_phone_numbers, [:country_code, :extension]
  end

  def self.down
    remove_index :address_book_phone_numbers, [:country_code, :extension]
  end
end
