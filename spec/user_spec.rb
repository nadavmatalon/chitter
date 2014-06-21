describe User do

	# context "" do

		it "has a name" do
			user = create_user
			expect(user.name).to eq "John Apple"
		end

		it "has a username" do
			user = create_user
			expect(user.username).to eq "JA"
		end

		it "has an email" do
			user = create_user
			expect(user.email).to eq "ja@gmail.com"
		end

		it "has it\'s password saved as a hash" do
			user = create_user
			expect(user.password_digest).not_to be "apples"
			expect(user.password_digest.chars.count).to eq 60
		end

		it "must have a name, username email, and password" do
			User.create
			expect(User.count).to eq 0
			User.create(name: "John Apple")
			expect(User.count).to eq 0
			User.create(username: "JA")
			expect(User.count).to eq 0
			User.create(email: "ja@gmail.com")
			expect(User.count).to eq 0
			User.create(name: "John Apple", username: "JA", email: "ja@gmail.com")
			expect(User.count).to eq 0
			create_user
			expect(User.count).to eq 1
		end

		it "can add a peep" do
			User.create(name: "Joan Apple", username: "JA", email: "ja@gmail.com", 
				password: "apple", password_confirmation: "apple",
				peeps: [Peep.create(time: "14:00", content: "The thoughts of John Apple")])
			expect(User.count).to eq 1	
			expect(Peep.count).to eq 1
			expect(User.first.name).to eq "Joan Apple"	
			expect(User.first.peeps.first.time).to eq "14:00"		
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

