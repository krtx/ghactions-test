require 'jwt'
require 'base64'
require 'optparse'

params = {}

opt = OptionParser.new
opt.on('-i val', '--iss') { |v| params[:iss] = v }
opt.on('-k val', '--kid') { |v| params[:kid] = v }
opt.parse!

private_key = STDIN.readlines.join
key = OpenSSL::PKey::EC.new(private_key)

payload = {
  iss: params[:iss],
  exp: Time.now.utc.to_i + 10 * 60,
  aud: 'appstoreconnect-v1'
}

header_fields = {
  "kid": params[:kid],
  "typ": 'JWT'
}

token = JWT.encode(payload, key, 'ES256', header_fields=header_fields)

puts token