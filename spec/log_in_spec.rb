
feature "User" do

	scenario "can go to the login page" do
		visit "/"
		expect(page.status_code).to eq 200
		click_button "Log In"
		expect(page).to have_content("Welcome, existing user")
		expect(page.status_code).to eq 200
	end

	scenario "can go back to home page" do
		visit "/"
		expect(page.status_code).to eq 200
		click_button "Log In"
		expect(page.status_code).to eq 200
		click_button "Back"
		expect(page).to have_content("Peep List")
		expect(page.status_code).to eq 200
	end

	scenario "can sign up by entering email and passowrd" do
		sign_up
		click_button "Log Out"
		log_in
		expect(page).to have_content("Welcome, JA")
	end

	scenario "is returned to the homepage after signing up" do
		sign_up
		expect(page.status_code).to eq 200
		expect(page).to have_button("Submit")
	end

	scenario "is asked to try again if email does not exist in database" do		
		log_in("jp@gmail.com", "apple")
		expect(page).to have_content("Please try again")
	end

	scenario "is asked to try again if password is incorrect" do
		sign_up
		click_button "Log Out"
		log_in("jp@gmail.com", "pear")
		expect(page).to have_content("Please try again")
	end

	scenario "cannot login without filling in email" do
		sign_up
		click_button "Log Out"
		log_in("", "apple")
		expect(page).to have_content("Please try again")
	end

	scenario "cannot login without filling in password" do
		sign_up
		click_button "Log Out"
		log_in("ja@gmail.com", "")
		expect(page).to have_content("Please try again")
	end

	scenario "remains logged in even if page is refreshed" do
		sign_up
		click_button "Log Out"
		log_in
		visit "/"
		expect(page).to have_content("Welcome, JA")
	end

	scenario "can go back to home page without signing up" do
		visit "/"
		expect(page.status_code).to eq 200
		click_button "Log In"
		expect(page.status_code).to eq 200
		click_button "Back"
		expect(page).to have_content("Peep List")
		expect(page.status_code).to eq 200
	end


	def log_in(email = "ja@gmail.com", password = "apple")
		visit "/"
		click_button "Log In"
		expect(page.status_code).to eq 200
		fill_in :email, :with => email
		fill_in :password, :with => password
		click_button "Submit"
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

