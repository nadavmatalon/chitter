require "data_mapper"

class Peep

	include DataMapper::Resource

	property :id, Serial
	property :time, String
	property :content, Text
end


