class CreateContacts < ActiveRecord::Migration
  def self.up
    create_table :address_book_contacts do |t|
      %w( first_name
          last_name
          title
          email
          skype
          website
          street
          city
          state
          zip ).each do |str_field|
        t.string str_field.to_sym                  
      end
      
      %w( comments
          descriptors	).each do |text_field|
        t.text text_field.to_sym                  
      end
                              
      t.timestamps
    end
  end

  def self.down
    drop_table :address_book_contacts
  end
end
