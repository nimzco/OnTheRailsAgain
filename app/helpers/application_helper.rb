module ApplicationHelper
  include TweetButton
  TweetButton.default_tweet_button_options = {:via => "OnTheRailsBlog"}

	def is_mobile?
		return /(\b(iphone|ipod|android)\b)|(W3C-mobile)/i.match(request.env["HTTP_USER_AGENT"])
	end
  def is_ipad?
		return /(\b(ipad)\b)/i.match(request.env["HTTP_USER_AGENT"])
	end
end
