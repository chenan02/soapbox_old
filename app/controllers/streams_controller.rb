class StreamsController < ApplicationController
  def new
  end

   def send_all
     @stream = Stream.find(params[:id])
     @followers = @stream.followers
     @body = get_tweet(@stream)
     send_message(@followers, @body)
   end
end



streams = {
	"Tech" => ["TheHackerNews", "TechCrunch", "newsycombinator"],
	"Politics" => ["politicalwire", "BBC", "NPR", "nytimes"],
	"Sports" => ["espn"],
	"Finance" => ["EconBizFin", "financialtimes"]
}