
require 'sinatra'
require 'nokogiri'
require 'open-uri'


get '/' do
#	puts request.query_string

	uri = 'http://juggly.cn/feed'
	xpath = '/html/body/div/div[3]/div[2]'

	rss = Nokogiri::XML open uri
	rss.search('item').each do |v|
		item = Nokogiri open v.at('link').text
		contents = item.at xpath
		contents.search('script').each do |v| v.remove end
		contents.search('comment()').each do |v| v.remove end
		v.at('description').child.remove
		v.at('description') << Nokogiri::XML::CDATA.new(v.document, contents.to_s)
		sleep 1
	end
	rss.to_s
end

