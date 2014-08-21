
feature "Users" do

	before (:each) { visit "/" }

	scenario "can navigate to the 'sign in' page" do
		click_button "Sign in"
		expect(page.status_code).to eq 200
		expect(page.current_path).to eq "/sign-in"
		within ".sign-in-title" do
			expect(page).to have_content "Sign in"
		end
	end

	scenario "can navigate back to 'home' page" do
		click_button "Sign in"
		click_button "Home"
		expect(page.status_code).to eq 200
		expect(page.current_path).to eq "/"
	end

	scenario "can sign in by entering an email and a passowrd" do
		register_user
		sign_in
		expect(page).to have_content "Welcome TU"
	end

	scenario "are automatically redirected to the homepage after signing-in" do
		register_user
		sign_in
		expect(page.current_path).to eq "/"
	end

	scenario "are asked to try again if email is incorrect" do		
		register_user
		sign_in "no@email.com", "password"
		expect(page.current_path).to eq "/sign-in-user"
		expect(page).to have_content "Sorry, please try again"
	end

	scenario "are asked to try again if password is incorrect" do
		register_user
		sign_in "tu@email.com", "wrong"
		expect(page.current_path).to eq "/sign-in-user"
		expect(page).to have_content "Sorry, please try again"
	end

	scenario "cannot sign-in without filling-in their email" do
		register_user
		sign_in "", "password"
		expect(page.current_path).to eq "/sign-in-user"
		expect(page).to have_content "Sorry, please try again"
	end

	scenario "cannot sign-in without filling-in their password" do
		register_user
		sign_in "tu@email.com", ""
		expect(page.current_path).to eq "/sign-in-user"
		expect(page).to have_content "Sorry, please try again"
	end

	scenario "cannot sign-in if already signed-in" do
		register_user
		sign_in
		expect(page).not_to have_button "Sign_in"
	end

	scenario "remain signed-in even if the page is refreshed" do
		register_user
		sign_in
		visit "/"
		expect(page).to have_content "Welcome TU"
	end
end