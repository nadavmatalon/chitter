
describe "Users", type: :feature, js: true do

	before (:each) { visit "/" }

	it "can open the 'sign in' box on the page" do
		click_button "Sign in"
		within ".sign-in-popup" do
			expect(page).to have_content "Sign in"
		end
	end

	it "can close the 'sign in' box on the page" do
		click_button "Sign in"
		within ".sign-in-popup" do
			click_button "x"
			expect(page).not_to have_css ".sign-in-popup"
		end
	end

	it "can sign in by entering an email and a passowrd" do
		register_user
		sign_in
		expect(page).to have_content "Welcome TU"
	end

	it "are asked to try again if email is incorrect" do		
		register_user
		sign_in "tu@email.com", "wrong"
		expect(page).to have_content "Sorry, please try again"
	end

	it "are asked to try again if password is incorrect" do
		register_user
		sign_in "tu@email.com", "wrong"
		expect(page).to have_content "Sorry, please try again"
	end

	it "cannot sign-in without filling-in their email" do
		register_user
		sign_in "", "password"
		expect(page).to have_content "Sorry, please try again"
	end

	it "cannot sign-in without filling-in their password" do
		register_user
		sign_in "tu@email.com", ""
		expect(page).to have_content "Sorry, please try again"
	end

	it "cannot sign-in if already signed-in" do
		register_user
		sign_in
		expect(page).not_to have_button "Sign_in"
	end

	it "remain signed-in even if the page is refreshed" do
		register_user
		sign_in
		click_button "Home"
		expect(page).to have_content "Welcome TU"
	end
end
