require "data_mapper"

class Peep

	include DataMapper::Resource

	property :id, Serial
	property :time, String, :default => Proc.new {|r, p| "[#{Date.today.day}-#{Date.today.month}-#{Date.today.year} #{Time.now.strftime("%I:%M%p")}]"}
	property :content, Text, required: true, message: "A peep must have content"



end

