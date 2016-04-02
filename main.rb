require_relative 'twitter'
require_relative 'twilio'

streams = {
	"Tech" => ["TechCrunch", "TheHackersNews", "newsycombinator"],
	"Politics" => ["politicalwire", "BBC", "NPR", "nytimes"],
	"Sports" => ["espn"],
	"Finance" => ["EconBizFin", "financialtimes"]
}

body = function(streams["Finance"])
send_message(body)