
def sign_up(name = "Test User", username = "TU", email = "tu@email.com", password = "password", password_confirmation = "password")
	visit "/"
	click_button "Sign up"
	within ".sign-up-container" do
		fill_in :name, with: name
		fill_in :username, with: username
		fill_in :email, with: email
		fill_in :password, with: password
		fill_in :password_confirmation, with: password_confirmation
		click_button "Submit"
	end
end

def sign_in(email = "tu@email.com", password = "password")
	visit "/"
	click_button "Sign in"
	fill_in :email, with: email
	fill_in :password, with: password
	click_button "Submit"
end

def sign_out 
	visit "/"
	click_button "Sign out"
end

def register_user
	sign_up
	sign_out
end

def user_create_peep
	sign_up
	fill_in :peep_content, with: "The thoughts of Test User"
	click_button "Submit"
	click_button "Sign out"
end
