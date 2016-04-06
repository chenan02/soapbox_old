require 'rubygems'
require 'twilio-ruby'
 
def send_message(users, body)
	account_sid = "AC892d1ad25d2cd70dd0880beb725a1bf4"
	auth_token = "4b4820bbab194b3cb12ae7e4352b1d10"
	client = Twilio::REST::Client.new account_sid, auth_token
	 
	from = "+12488262836" # Your Twilio number
	 
	#friends = {
	#"2483809188" => "Andrew Chen"
	#}
	users.each do |key, value|
	  client.account.messages.create(
	    :from => from,
	    :to => key,
	    :body => body
	  )
	  puts "Sent message to #{value}"
	end
end