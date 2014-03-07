# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
Cloud::Application.config.secret_key_base = 'b9b1dc230c2a1f572844c3122a09d28ac0ad968d5b2f7a53b44ec7a49d8ecebb009a5b4d83e85320b176a74038ad368ee4b0c4fc56e264ac4d117a471677d648'
