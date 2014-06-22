describe Peep do

		it "has a content" do
			peep = Peep.create(content: "The thoughts of John Apple")
			expect(Peep.count).to eq 1
			expect(peep.content).to eq "The thoughts of John Apple"
		end

		it "must have content" do
			Peep.create
			expect(Peep.count).to eq 0
		end

		it "is created with a time stamp" do
			peep = Peep.create(content: "The thoughts of John Apple")
			expect(peep.time).not_to be_nil
		end
end


feature "User" do

	scenario "can access the add peep section while being logged in" do
		sign_up
		expect(page).to have_button("Submit")
		expect(page).to have_field(id="peep_content", type="textarea")
	end

	scenario "cannot access the add peep section if not being logged in" do
		visit "/"
		expect(page).not_to have_button("Submit")
		expect(page).not_to have_field(id="peep_content", type="textarea")
	end

	scenario "can post a peep while logged in" do
		sign_up
		fill_in :peep_content, :with => "The thoughts of John Apple"
		click_button("Submit")
		expect(page).to have_content("Thanks JA, peep posted!")
	end

	scenario "cannot post an empty peep" do
		sign_up
		click_button("Submit")
		expect(page).not_to have_content("Thanks JA, peep posted!")
	end

	def sign_up(name = "John Apple", username = "JA", email = "ja@gmail.com", password = "apple", password_confirmation = "apple")
		visit "/"
		click_button "Sign Up"
		expect(page.status_code).to eq 200
		fill_in :name, :with => name
		fill_in :username, :with => username
		fill_in :email, :with => email
		fill_in :password, :with => password
		fill_in :password_confirmation, :with => password_confirmation
		click_button "Submit"
	end

end