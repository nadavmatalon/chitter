class TimeStamp

	MONTHS = ["none", "January", "February", "March", "April", "May", "June", 
			  "July", "August", "September", "October", "November", "December"]

	def self.date_str
		day = Date.today.day
		month = MONTHS[Date.today.month]
		year = Date.today.year
		"#{day} #{month} #{year}"
	end

	def self.time_str
		Time.now.strftime("%I:%M%p")
	end

	def self.now
		"#{date_str} #{time_str}"
	end

	# alt Time.now.strftime("%d/%m/%y %I:%M%p")


end


