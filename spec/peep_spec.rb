describe Peep do

	# context "" do

		it "" do
		end


		def create_peep (time = "14:00", content = "The thoughts of John Apple")
			Peep.create(time: time, content: content)
		end

		def create_user (name = "John Apple", username = "JA", email = "ja@gmail.com", 
						 password = "apples", peeps = [])
			User.create(name: name, username: username, 
						email: email, password: password,
						password_confirmation: password,
						peeps: peeps)
		end
	# end
end

