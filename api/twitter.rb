require 'rubygems'
require 'oauth'
require 'json'

def most_favorited(tweets)
	most_favorited = tweets.max_by { |tweet| tweet["favorite_count"] }
	most_favorited["text"]
end

def function(streams)
	all_tweets = []
	streams.each do |stream|
		baseurl = "https://api.twitter.com"
		path    = "/1.1/statuses/user_timeline.json"
		query   = URI.encode_www_form(
		    "screen_name" => stream,
		    "count" => 10,
		)
		address = URI("#{baseurl}#{path}?#{query}")
		#`puts address
		request = Net::HTTP::Get.new address.request_uri

		# Set up HTTP.
		http             = Net::HTTP.new address.host, address.port
		http.use_ssl     = true
		http.verify_mode = OpenSSL::SSL::VERIFY_PEER

		# If you entered your credentials in the first
		# exercise, no need to enter them again here. The
		# ||= operator will only assign these values if
		# they are not already set.
		consumer_key = OAuth::Consumer.new "NrQv1IY3O5iJT2qZAVjT9KzhS", "6clcABmnfsbpNASrAFYwKsLVoe0M436DxyNmrKkdTU5a9v6vSj"
		access_token = OAuth::Token.new "3244261188-Zo5HTVcGOqz0pPENbTPqzPH02KcifKq6008kCHa", "VLDa2JqYJpgxcDi8eJTYNveL0nMyR5ujVrBPLwMEvWaRm"

		# Issue the request.
		request.oauth! http, consumer_key, access_token
		http.start
		response = http.request request

		# Parse and print the Tweet if the response code was 200
		tweets = nil
		if response.code == '200' then
			tweets = JSON.parse(response.body)
			tweets.each do |tweet|
			  	all_tweets.push(tweet)
			end
		end
	end
	most_favorited(all_tweets)
end