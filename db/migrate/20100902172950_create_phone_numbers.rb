class CreatePhoneNumbers < ActiveRecord::Migration
  def self.up
    create_table :address_book_phone_numbers do |t|
      t.string :number
      t.string :label
      
      t.timestamps
    end
    
    create_table :address_book_contacts_phone_numbers, :id => false do |t|
      t.integer :contact_id
      t.integer :phone_number_id
    end
  end

  def self.down
    drop_table :address_book_phone_numbers
  end
end
