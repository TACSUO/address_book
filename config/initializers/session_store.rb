# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_address-book_session',
  :secret      => '695b4451873dd29f4ab918aed6eae8b00d450087ebedddc5b0accb2d6234eeabe7d9b5dc1bd94029cbed332a224adb2614560bf84ce583eba4308f38c36da1b3'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
