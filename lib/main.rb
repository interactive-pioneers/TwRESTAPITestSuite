require 'oauth'
require 'json'
require 'yaml'

# Exchange your oauth_token and oauth_token_secret for an AccessToken instance.
def prepare_access_token(config)
  consumer = OAuth::Consumer.new(config['consumer_key'], config['consumer_secret'],
    { :site => "http://api.twitter.com",
      :scheme => :header
    })
  # now create the access token object from passed values
  token_hash = { :oauth_token => config['oauth_token'],
                 :oauth_token_secret => config['oauth_token_secret']
               }
  access_token = OAuth::AccessToken.from_hash(consumer, token_hash )
  return access_token
end

# Load configuration
config = YAML.load_file('config/config.yml')

# Exchange our oauth_token and oauth_token secret for the AccessToken instance.
access_token = prepare_access_token(config)

# use the access token as an agent to get the home timeline
# fetches the latest item from the timeline that the app is bound to
response = access_token.request(:get, "https://api.twitter.com/1.1/statuses/home_timeline.json?count=1")

# Output the response
puts response.body