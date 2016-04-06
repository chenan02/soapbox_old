class StreamsController < ApplicationController
  def new
  end
end



streams = {
	"Tech" => ["TheHackerNews", "TechCrunch", "newsycombinator"],
	"Politics" => ["politicalwire", "BBC", "NPR", "nytimes"],
	"Sports" => ["espn"],
	"Finance" => ["EconBizFin", "financialtimes"]
}