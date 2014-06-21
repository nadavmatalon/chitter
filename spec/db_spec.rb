describe "Data_Mapper" do

	context "Demonstration of how datamapper works" do

		it "should create new user and then retrieve it from the database" do
			expect(User.count).to eq(0)
			create_user
			expect(User.count).to eq(1)
			user = User.first
			expect(user.name).to eq("John Apple")
			expect(user.username).to eq("JA")
			expect(user.email).to eq("ja@gmail.com")
		end	

		it "should create new peep and then retrieve it from the database" do
			expect(Peep.count).to eq 0
			create_peep
			expect(Peep.count).to eq 1
			peep = Peep.first
			expect(peep.time).to eq("14:00")
			expect(peep.content).to eq("The thoughts of John Apple")
		end	

		it "should create new user with peep and then retrieve them from the database" do
			expect(User.count).to eq 0
			expect(Peep.count).to eq 0
			User.create(name: "John Apple", username: "JA", peeps: [create_peep])
			expect(User.count).to eq 1
			expect(Peep.count).to eq 1
			expect(User.first.username).to eq("JA")
			expect(User.first.peeps.first.time).to eq("14:00")
			expect(User.first.peeps.first.content).to eq("The thoughts of John Apple")
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
	end
end


