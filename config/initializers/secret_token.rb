# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
if defined?(AddressBook::Application)
  AddressBook::Application.config.secret_token = 'f9e375eb91a3e28618da2bf1497e4086c2e48cdffe6bc2cb850776fb4383c3586cfa15fdaf050926f35a186dc4630aa7dac52ec564707a788cbab76cfb8de730'
end
