require_relative 'twitter'
require_relative 'twilio'

streams = {
	"Tech" => ["TechCrunch", "TheHackersNews", "newsycombinator"],
	"Politics" => ["politicalwire", "BBC", "NPR", "nytimes"],
	"Sports" => ["espn"],
	"Finance" => ["EconBizFin", "financialtimes"]
}

users = {
	"2483809188" => "Andrew Chen"
}

body = get_tweet(streams["Politics"])
send_message(users, body)