
feature "User" do

	scenario "can go to sign up page" do
		visit "/"
		expect(page.status_code).to eq 200
		click_button "Sign Up"
		expect(page).to have_content("Welcome, new user")
		expect(page.status_code).to eq 200
	end

	scenario "can go back to home page" do
		visit "/"
		expect(page.status_code).to eq 200
		click_button "Sign Up"
		expect(page.status_code).to eq 200
		click_button "Back"
		expect(page).to have_content("Peep List")
		expect(page.status_code).to eq 200
	end

	scenario "can sign up by entering name, user-name, email, password and password-confirmation" do
		expect(User.count).to eq 0
		lambda {sign_up}.should change(User, :count).by 1
		# expect(User.first.email).to eq ("ja@gmail.com")
	end

	scenario "is returned to the homepage after signing up" do
		sign_up
		expect(page.status_code).to eq 200
		expect(page).to have_content("Welcome, JA")
	end

	scenario "details are saved in the database after signing up" do
		sign_up
		expect(User.first.name).to eq ("John Apple")
		expect(User.first.username).to eq ("JA")
		expect(User.first.email).to eq ("ja@gmail.com")
	end

	scenario "password is saved as a hash in the database after signing up" do
		sign_up
		expect(User.first.password_digest).not_to eq ("apple")
	end

	scenario "is asked to try again if sign up does not work" do
		sign_up_2
		expect(page.status_code).to eq 200
		expect(page).to have_content("Please try again")
	end

	scenario "cannot sign up without filling in name" do
		expect(User.count).to eq 0
		lambda {sign_up(name = "")}.should change(User, :count).by 0
		expect(page.status_code).to eq 200
	end

	scenario "cannot sign up without filling in username" do
		expect(User.count).to eq 0
		lambda {sign_up(username = "")}.should change(User, :count).by 0
		expect(page.status_code).to eq 200
	end

	scenario "cannot sign up without filling in password" do
		expect(User.count).to eq 0
		lambda {sign_up(password = "")}.should change(User, :count).by 0
		expect(page.status_code).to eq 200
	end

	scenario "cannot sign up without filling in password confirmation" do
		expect(User.count).to eq 0
		lambda {sign_up(password_confirmation = "")}.should change(User, :count).by 0
		expect(page.status_code).to eq 200
	end

	scenario "cannot sign up with unmatching password and password confirmation" do
		expect(User.count).to eq 0
		# lambda {sign_up(passowrd = "apple", password_confirmation = "pear")}.should change(User, :count).by 0
		lambda {sign_up_2}.should change(User, :count).by 0
		expect(User.count).to eq 0
		expect(page.status_code).to eq 200
	end

	scenario "cannot sign up with an email that is already registered" do
		lambda {sign_up}.should change(User, :count).by(1)
		click_button "Log Out"
		lambda {sign_up}.should change(User, :count).by(0)
		expect(page).to have_content("Please try again")
	end

	scenario "can go back to home page without signing up" do
		visit "/"
		expect(page.status_code).to eq 200
		click_button "Sign Up"
		expect(page.status_code).to eq 200
		click_button "Back"
		expect(page).to have_content("Peep List")
		expect(page.status_code).to eq 200
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

		def sign_up_2
		visit "/"
		click_button "Sign Up"
		expect(page.status_code).to eq 200
		fill_in :name, :with => "John Apple 7"
		fill_in :username, :with => "JA7"
		fill_in :email, :with => "ja7@gmail.com"
		fill_in :password, :with => "apple"
		fill_in :password_confirmation, :with => "pear"
		click_button "Submit"
	end
end

