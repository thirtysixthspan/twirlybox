# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_twirlybox_session',
  :secret      => 'c4cf702a59249346e9a3cbe9b58a909ce1048ab4ce100410c2d82b8cb97d69aaea8d64d920cfcef3210838a6937333689c9db52d6cea5cb0cb722c41a7750687'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
