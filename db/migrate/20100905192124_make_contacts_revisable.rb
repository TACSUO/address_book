class MakeContactsRevisable < ActiveRecord::Migration
  def self.up
    add_column :address_book_contacts, :revisable_original_id, :integer
    add_column :address_book_contacts, :revisable_branched_from_id, :integer
    add_column :address_book_contacts, :revisable_number, :integer, :default => 0
    add_column :address_book_contacts, :revisable_name, :string
    add_column :address_book_contacts, :revisable_type, :string
    add_column :address_book_contacts, :revisable_current_at, :datetime
    add_column :address_book_contacts, :revisable_revised_at, :datetime
    add_column :address_book_contacts, :revisable_deleted_at, :datetime
    add_column :address_book_contacts, :revisable_is_current, :boolean, :default => true
  end

  def self.down
    remove_column :address_book_contacts, :revisable_original_id
    remove_column :address_book_contacts, :revisable_branched_from_id
    remove_column :address_book_contacts, :revisable_number
    remove_column :address_book_contacts, :revisable_name
    remove_column :address_book_contacts, :revisable_type
    remove_column :address_book_contacts, :revisable_current_at
    remove_column :address_book_contacts, :revisable_revised_at
    remove_column :address_book_contacts, :revisable_deleted_at
    remove_column :address_book_contacts, :revisable_is_current
  end
end
