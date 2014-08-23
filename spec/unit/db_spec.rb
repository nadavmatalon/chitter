
Capybara.current_driver = :webkit 

describe "Data_Mapper" do

	context "Demonstration of how DataMapper works" do

		it "should create new user and then retrieve it from the database" do
			expect(User.count).to eq(0)
			create_user
			expect(User.count).to eq(1)
			expect(User.first.name).to eq("Test User")
			expect(User.first.username).to eq("TU")
			expect(User.first.email).to eq("tu@email.com")
		end	

		it "should create new peep and then retrieve it from the database" do
			expect(Peep.count).to eq 0
			User.create(name: "Test User", username: "TU", email: "tu@email.com", password: "password", password_confirmation: "password", peeps: [create_peep])
			expect(Peep.count).to eq 1
			expect(Peep.first.time).to eq("14:00")
			expect(Peep.first.content).to eq("The thoughts of Test User")
		end	
	end
end

Capybara.use_default_driver     



