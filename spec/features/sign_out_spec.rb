feature "Users" do

	before (:each) { visit "/" }

	scenario "cannot sign-out unless they first sign-up" do
		expect(page).not_to have_button "Sign out"
	end

	scenario "can sign-out after signing-up" do
		sign_up
		expect(page).to have_content "Welcome TU"
		click_button "Sign out"
		expect(page).to have_content "Welcome Guest"
	end

	scenario "can sign-out after signing-in" do
		register_user
		sign_in
		expect(page).to have_content "Welcome TU"
		click_button "Sign out"
		expect(page).to have_content "Welcome Guest"
	end

	scenario "can't sign-out after signing-out without signing-in" do
		sign_up
		click_button "Sign out"
		expect(page).not_to have_button "Sign out"
	end
end