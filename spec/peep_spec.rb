feature "Peep" do

	scenario "has content" do
		sign_up
		fill_in :peep_content, :with => "The thoughts of John Apple"
		click_button("Submit")
		expect(Peep.count).to eq 1
	end

	scenario "must have content" do
		Peep.create
		expect(Peep.count).to eq 0
	end

	scenario "is created with a time stamp" do
		peep = Peep.create(content: "The thoughts of John Apple")
		expect(peep.time).not_to be_nil
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

feature "User" do

	scenario "can see the list of previous peeps even if not logged in" do
		sign_up
		fill_in :peep_content, :with => "The thoughts of John Apple"
		click_button("Submit")
		click_button("Log Out")
		expect(page).to have_content("The thoughts of John Apple")
	end

	scenario "can see the list of previous peeps if logged in" do
		sign_up
		fill_in :peep_content, :with => "The thoughts of John Apple"
		click_button("Submit")
		field = find_field(id="peep_content", type="textarea").value
		expect(field).to be_empty
		expect(page).to have_content("The thoughts of John Apple")
	end

	scenario "can access the submit peep section while being logged in" do
		sign_up
		expect(page).to have_button("Submit")
		expect(page).to have_field(id="peep_content", type="textarea")
	end

	scenario "can post a peep while logged in" do
		sign_up
		fill_in :peep_content, :with => "The thoughts of John Apple"
		click_button("Submit")
		expect(page).to have_content("Thanks JA, peep posted!")
	end

	scenario "cannot post a new peep if not logged in" do
		visit "/"
		expect(page).not_to have_button("Submit")
		expect(page).not_to have_field(id="peep_content", type="textarea")
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

