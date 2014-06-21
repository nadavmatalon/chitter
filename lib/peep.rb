require "data_mapper"

class Peep

	include DataMapper::Resource

	property :id, Serial
	property :time, String, :default => Proc.new {|r, p| "[" + Time.now.strftime("%C %B %Y %I:%M%p") + "]"}
	property :content, Text, required: true, message: "A peep must have content"



end

