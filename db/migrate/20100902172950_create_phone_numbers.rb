class CreatePhoneNumbers < ActiveRecord::Migration
  def self.up
    create_table :address_book_phone_numbers do |t|
      t.string :country_code, :default => "1", :limit => 15
      t.string :local_number, :limit => 15
      t.string :extension, :limit => 15
      t.string :label, :limit => 31
      
      t.timestamps
    end
    
    create_table :address_book_contacts_phone_numbers, :id => false do |t|
      t.integer :contact_id
      t.integer :phone_number_id
    end
  end

  def self.down
    drop_table :address_book_phone_numbers
    drop_table :address_book_contacts_phone_numbers
  end
end
