class TimeStamp

	MONTHS = ["none", "January", "February", "March", "April", "May", "June", 
			  "July", "August", "September", "October", "November", "December"]

	def self.date_str
		day = date_today.day
		month = MONTHS[date_today.month]
		year = date_today.year
		"#{day} #{month} #{year} | "
	end

	def self.date_today
		Date.today
	end

	def self.time_str
		Time.now.strftime("%-l:%M %p")
	end

	def self.now
		"#{date_str} #{time_str}"
	end
end


