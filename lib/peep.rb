require "data_mapper"
require_relative "TimeStamp.rb"

class Peep

	include DataMapper::Resource

	belongs_to :user

	property :id, Serial
	property :time, String, default: Proc.new { "#{TimeStamp.now}"}
	property :content, Text, required: true, message: "A peep must have content"

	def find_author
		User.get(user_id).username
	end
end

