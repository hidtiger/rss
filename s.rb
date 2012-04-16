require 'sinatra'


get '/' do
	puts request.query_string
	"hogehoge"
end

