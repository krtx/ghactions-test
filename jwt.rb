require 'jwt'
require 'base64'

private_key = Base64.decode64(ARGV[0])
key = OpenSSL::PKey::EC.new(private_key)

payload = {
  iss: "69a6de85-01eb-47e3-e053-5b8c7c11a4d1",
  exp: Time.now.utc.to_i + 10 * 60,
  aud: "appstoreconnect-v1"
}

header_fields = {
  "kid": "6XZA3ZKNY3",
  "typ": "JWT"
}

token = JWT.encode payload, key, "ES256", header_fields=header_fields

puts token
