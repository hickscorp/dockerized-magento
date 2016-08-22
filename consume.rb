%w(oauth json).each { |g| require g }

URL='http://dockerized-magento.local'
CONSUMER_KEY='a177218da8fa124f918db9a6ec101562'
CONSUMER_SECRET='6b96bbbf552551ae2562d5bb60bc411f'
OAUTH_TOKEN='331f461c3456719c92fe659b4514745f'
OAUTH_TOKEN_SECRET='deb45bf39103df2a55b8b668e003aff4'

consumer = OAuth::Consumer.new CONSUMER_KEY, CONSUMER_SECRET, site: URL, signature_method: 'HMAC-SHA1', scheme: :header
access_token = OAuth::AccessToken.new consumer, OAUTH_TOKEN, OAUTH_TOKEN_SECRET

res = access_token.get('/api/rest/products').body
JSON::parse(res).each do |_, data|
  entity = OpenStruct.new data
  puts "#{entity.entity_id} => #{entity.name}"
end

res = access_token.get('/api/rest/snappic/stores/current').body
puts res
