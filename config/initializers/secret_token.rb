# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
Slooly::Application.config.secret_token = '6acdafa49290b589727e357ac27754c5ff38f2e2f859107c927ff87b4ea7e446c16b3c0a7f4df28dd1601996e3cea08f27cc2959c8a6303ba8221becc9c4e690'
Slooly::Application.config.secret_key_base = 'cf97419aefbca238c9055a8e56cad5c6784c514e028b02c84dc7e871d1e15845cf280381c27e286b42a8918e66fa0d47a5245998e2a7334732b50ffee0230a0d' # this needs to be added