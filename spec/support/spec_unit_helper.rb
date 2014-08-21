def create_user (name = "Test User", username = "TU", email = "tu@email.com", 
				 password = "password", peeps = [])
	User.create(name: name, username: username, 
				email: email, password: password,
				password_confirmation: password,
				peeps: peeps)
end

def create_peep (time = "14:00", content = "The thoughts of Test User")
	Peep.create(time: time, content: content)
end
