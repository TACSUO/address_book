# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100909205012) do

  create_table "address_book_contacts", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "title"
    t.string   "email"
    t.string   "skype"
    t.string   "website"
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.text     "comments"
    t.text     "descriptors"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "revisable_original_id"
    t.integer  "revisable_branched_from_id"
    t.integer  "revisable_number",           :default => 0
    t.string   "revisable_name"
    t.string   "revisable_type"
    t.datetime "revisable_current_at"
    t.datetime "revisable_revised_at"
    t.datetime "revisable_deleted_at"
    t.boolean  "revisable_is_current",       :default => true
    t.text     "phonebook"
  end

  create_table "address_book_contacts_phone_numbers", :id => false, :force => true do |t|
    t.integer "contact_id"
    t.integer "phone_number_id"
  end

  create_table "address_book_phone_numbers", :force => true do |t|
    t.string   "country_code",               :limit => 15, :default => "1"
    t.string   "local_number",               :limit => 15
    t.string   "extension",                  :limit => 15
    t.string   "label",                      :limit => 31
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "revisable_original_id"
    t.integer  "revisable_branched_from_id"
    t.integer  "revisable_number",                         :default => 0
    t.string   "revisable_name"
    t.string   "revisable_type"
    t.datetime "revisable_current_at"
    t.datetime "revisable_revised_at"
    t.datetime "revisable_deleted_at"
    t.boolean  "revisable_is_current",                     :default => true
    t.text     "reverse_phonebook"
  end

  add_index "address_book_phone_numbers", ["country_code", "extension"], :name => "index_address_book_phone_numbers_on_country_code_and_extension"

end
