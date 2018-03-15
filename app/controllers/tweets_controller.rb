require "base64"
require "unirest"

class TweetsController < ApplicationController
  def index
    # Index encodes the consumer and secret key to be passed to the twitter api in order to obtain a token. 
    consumer_key = ENV["consumer_key"]
    consumer_secret = ENV["consumer_secret"]
    encode_secret = Base64.encode64("#{consumer_key}:#{consumer_secret}").gsub("\n", "")
    twitter_api = 'https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=ConanOBrien&count=5'
    response = Unirest.post "https://api.twitter.com/oauth2/token", 
                            headers:{ 
                              'Authorization': "Basic #{encode_secret}",
                              'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8'
                             }, 
                            parameters:{grant_type: 'client_credentials'}
                            
    # Once we are authroized was the token and make a get request for 5 conan tweets
    response2 = Unirest.get twitter_api, 
                            headers:{Authorization: "Bearer #{response.body["access_token"]}"}
  


    render json: response2.body
  end
end
