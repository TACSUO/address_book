class CreatePhoneNumbers < ActiveRecord::Migration
  def self.up
    create_table :address_book_phone_numbers do |t|
      t.integer :contact_id
      t.string :number
      t.string :label
      
      t.timestamps
    end
  end

  def self.down
    drop_table :address_book_phone_numbers
  end
end
