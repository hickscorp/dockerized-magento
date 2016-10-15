%w(oauth json).each { |g| require g }

URL=ARGV[0]
CONSUMER_KEY=ARGV[1]
CONSUMER_SECRET=ARGV[2]
OAUTH_TOKEN=ARGV[3]
OAUTH_TOKEN_SECRET=ARGV[4]

consumer = OAuth::Consumer.new CONSUMER_KEY, CONSUMER_SECRET, site: URL, signature_method: 'HMAC-SHA1', scheme: :header
access_token = OAuth::AccessToken.new consumer, OAUTH_TOKEN, OAUTH_TOKEN_SECRET

res = access_token.get('/api/rest/snappic/stores/current').body
puts res

res = access_token.get('/api/rest/products?page=1&limit=20').body
JSON::parse(res).each do |_, data|
  entity = OpenStruct.new data
  puts "#{entity.entity_id} => #{entity.name}"
end
