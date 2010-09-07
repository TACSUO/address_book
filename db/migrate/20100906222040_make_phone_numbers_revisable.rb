class MakePhoneNumbersRevisable < ActiveRecord::Migration
  def self.up
    add_column :address_book_phone_numbers, :revisable_original_id, :integer
    add_column :address_book_phone_numbers, :revisable_branched_from_id, :integer
    add_column :address_book_phone_numbers, :revisable_number, :integer, :default => 0
    add_column :address_book_phone_numbers, :revisable_name, :string
    add_column :address_book_phone_numbers, :revisable_type, :string
    add_column :address_book_phone_numbers, :revisable_current_at, :datetime
    add_column :address_book_phone_numbers, :revisable_revised_at, :datetime
    add_column :address_book_phone_numbers, :revisable_deleted_at, :datetime
    add_column :address_book_phone_numbers, :revisable_is_current, :boolean, :default => 1
  end

  def self.down
    remove_column :address_book_phone_numbers, :revisable_original_id
    remove_column :address_book_phone_numbers, :revisable_branched_from_id
    remove_column :address_book_phone_numbers, :revisable_number
    remove_column :address_book_phone_numbers, :revisable_name
    remove_column :address_book_phone_numbers, :revisable_type
    remove_column :address_book_phone_numbers, :revisable_current_at
    remove_column :address_book_phone_numbers, :revisable_revised_at
    remove_column :address_book_phone_numbers, :revisable_deleted_at
    remove_column :address_book_phone_numbers, :revisable_is_current
  end
end
