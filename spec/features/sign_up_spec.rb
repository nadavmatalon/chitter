
feature "Users" do

	before (:each) { visit "/" }

	scenario "can navigate to the 'sign up' page" do
		click_button "Sign up"
		expect(page.status_code).to eq 200
		expect(page.current_path).to eq "/sign-up"
		within ".sign-up-title" do
			expect(page).to have_content "Sign up"
		end
	end

	scenario "can navigate back to 'home' page" do
		click_button "Sign up"
		click_button "Home"
		expect(page.status_code).to eq 200
		expect(page.current_path).to eq "/"
	end

	scenario "can sign-up by entering name, username, email, password and password-confirmation" do
		sign_up
		expect(page).to have_content "Welcome TU"
	end

	scenario "are returned to the 'home' page after signing-up" do
		sign_up
		expect(page.status_code).to eq 200
		expect(page).to have_content "Welcome TU"
	end

	scenario "cannot sign-up without filling-in a name" do
		sign_up "", "TU", "tu@email.com", "password", "passowrd"
		expect(page.current_path).to eq "/sign-up-user"
		expect(page).to have_content "Sorry, please try again"
	end

	scenario "cannot sign-up without filling-in a username" do
		sign_up "Test User", "", "tu@email.com", "password", "passowrd"
		expect(page.current_path).to eq "/sign-up-user"
		expect(page).to have_content "Sorry, please try again"
	end

	scenario "cannot sign-up without filling-in an email" do
		sign_up "Test User", "TU", "", "password", "passowrd"
		expect(page.current_path).to eq "/sign-up-user"
		expect(page).to have_content "Sorry, please try again"
	end

	scenario "cannot sign-up without filling-in a password" do
		sign_up "Test User", "TU", "tu@email.com", "", "passowrd"
		expect(page.current_path).to eq "/sign-up-user"
		expect(page).to have_content "Sorry, please try again"
	end

	scenario "cannot sign-up without filling-in a password confirmation" do
		sign_up "Test User", "TU", "tu@email.com", "passowrd", ""
		expect(page.current_path).to eq "/sign-up-user"
		expect(page).to have_content "Sorry, please try again"
	end

	scenario "cannot sign-up with unmatching password and password confirmation" do
		sign_up "Test User", "TU", "tu@email.com", "passowrd", "anotehr_password"
		expect(page.current_path).to eq "/sign-up-user"
		expect(page).to have_content "Sorry, please try again"
	end

	scenario "cannot sign-up with a username that is already registered" do
		register_user
		sign_up "Another User", "TU", "an@email.com", "passowrd_two", "password_two"
		expect(page.current_path).to eq "/sign-up-user"
		expect(page).to have_content "Sorry, please try again"
	end

	scenario "cannot sign-up with an email that is already registered" do
		register_user
		sign_up "Another User", "AU", "tu@email.com", "passowrd_two", "password_two"
		expect(page.current_path).to eq "/sign-up-user"
		expect(page).to have_content "Sorry, please try again"
	end

	scenario "cannot sign-up if already signed-up" do
		sign_up
		expect(page).not_to have_button "Sign_up"
	end

	scenario "are automatically redirected to the homepage after signing-up" do
		sign_up
		expect(page.current_path).to eq "/"
	end
end

