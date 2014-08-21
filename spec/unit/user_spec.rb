describe User do

	it "have a name" do
		create_user
		expect(User.first.name).to eq "Test User"
	end

	it "have a username" do
		create_user
		expect(User.first.username).to eq "TU"
	end

	it "have an email" do
		create_user
		expect(User.first.email).to eq "tu@email.com"
	end

	it "have their password saved as a hash" do
		create_user
		expect(User.first.password_digest).not_to eq "password"
		expect(User.first.password_digest.chars.count).to eq 60
	end

	it "must have a name, username, email, and password" do
		User.create
		expect(User.count).to eq 0
		User.create(name: "Test User")
		expect(User.count).to eq 0
		User.create(username: "TU")
		expect(User.count).to eq 0
		User.create(email: "tu@email.com")
		expect(User.count).to eq 0
		User.create(name: "Test Users", username: "TU", email: "tu@email.com")
		expect(User.count).to eq 0
		create_user
		expect(User.count).to eq 1
	end

	it "can be created with a new peep" do
		User.create(name: "Test User", username: "TU", email: "tu@email.com", 
			password: "password", password_confirmation: "password",
			peeps: [Peep.create(time: "14:00", content: "The thoughts of Test User")])
		expect(User.count).to eq 1	
		expect(Peep.count).to eq 1
		expect(User.first.name).to eq "Test User"	
		expect(User.first.peeps.first.time).to eq "14:00"		
	end

	it "details are saved in the database after signing-up" do
		create_user
		expect(User.first.name).to eq "Test User"
		expect(User.first.username).to eq "TU"
		expect(User.first.email).to eq "tu@email.com"
	end
end


