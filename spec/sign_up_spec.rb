
feature "User signs-up" do

	scenario "by entering name, user-name, email, password and password-confirmation" do
		expect(User.count).to eq 0
		lambda {sign_up}.should change(User, :count).by 1
		expect(User.first.email).to eq ("ja@gmail.com")
	end

	def sign_up(name = "John Apple", username = "JA", email = "ja@gmail.com", 
				password = "apple", password_confirmation = "apple")
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






=begin

	scenario "can sign up" do
		lambda { sign_up }.should change(User, :count).by(1)
		expect(page).to have_content ("Welcome alice@example.com")
		expect(User.first.email).to eq ("alice@example.com")
	end

	scenario "cannot register with a password that doesn't match" do
		lambda { sign_up('a@a.com', 'pass', 'wrong') }.should change(User, :count).by(0) 
		expect(current_path).to eq('/users')
		expect(page).to have_content("Password does not match the confirmation")
	end

	scenario "with an email that is already registered" do
		lambda { sign_up }.should change(User, :count).by(1)
		lambda { sign_up }.should change(User, :count).by(0)
		expect(page).to have_content("This email is already taken")
	end

	def sign_up(email = "alice@example.com", password = "apple", password_confirmation = "apple")
		visit "/new_user"
		expect(page.status_code).to eq(200)
		fill_in :email, :with => email
		fill_in :password, :with => password
		fill_in :password_confirmation, :with => password_confirmation
		click_button "Register"
  end

end

feature "User signs in" do

	before(:each) do

		User.create(:email => "test@test.com", :password => "test",
					:password_confirmation => "test")
	end

	scenario "with correct credentials" do
		visit "/"
		expect(page).not_to have_content("Welcome test@test.com")
		sign_in("test@test.com", "test")
		expect(page).to have_content("Welcome test@test.com")
	end

	scenario "with incorrect credentials" do
		visit "/"
		expect(page).not_to have_content("Welcome test@test.com")
		sign_in("test@test.com", "wrong")
		expect(page).not_to have_content("Welcome test@test.com")
	end

	def sign_in(email, password)
		visit "/user_sign_in"
		fill_in "email", :with => email
		fill_in "password", :with => password
		click_button "Sign In"
	end

end


feature "User signs out" do

	before(:each) do
		User.create(:email => "test@test.com", :password => "test",
					:password_confirmation => "test")
	end

	scenario "while being signed in" do
		sign_in("test@test.com", "test")
		click_button "Sign out"
		expect(page).to have_content("Good bye!")
		expect(page).not_to have_content("Welcome test@test.com")
	end

	def sign_in(email, password)
		visit "/user_sign_in"
		fill_in "email", :with => email
		fill_in "password", :with => password
		click_button "Sign In"
	end

end





feature "User browses the list of links" do

	before(:each) {
		Link.create(:url => "http://www.makersacademy.com", :title => "Makers Academy",
					:tags => [Tag.first_or_create(:text => 'education')])
	}

	scenario "when opening the home page" do
		visit '/'
		expect(page).to have_content("Makers Academy")
	end
end

feature "User adds a new link" do

	scenario "when browsing the homepage" do

		expect(Link.count).to eq(0)
		visit '/'
		add_link("http://www.makersacademy.com/", "Makers Academy")
		expect(Link.count).to eq(1)
		link = Link.first
		expect(link.url).to eq("http://www.makersacademy.com/")
		expect(link.title).to eq("Makers Academy")
	end

	scenario "with a few tags" do
		visit "/"
		add_link("http://www.makersacademy.com/", "Makers Academy", ['education', 'ruby'])
		link = Link.first
		expect(link.tags.map(&:text)).to include("education")
		expect(link.tags.map(&:text)).to include("ruby")
	end
end

feature "User browses the list of links" do

	before(:each) {
		Link.create(:url => "http://www.makersacademy.com", :title => "Makers Academy",
					:tags => [Tag.first_or_create(:text => 'education')])

		Link.create(:url => "http://www.google.com", :title => "Google", 
					:tags => [Tag.first_or_create(:text => 'search')])

		Link.create(:url => "http://www.bing.com", :title => "Bing",
					:tags => [Tag.first_or_create(:text => 'search')])

		Link.create(:url => "http://www.code.org", :title => "Code.org",
					:tags => [Tag.first_or_create(:text => 'education')])
	}

	scenario "filtered by a tag" do
		visit '/tags/search'
		expect(page).not_to have_content("Makers Academy")
		expect(page).not_to have_content("Code.org")
		expect(page).to have_content("Google")
		expect(page).to have_content("Bing")
	end
end

def add_link(url, title, tags = [])			#this is a helper method - in practice the data
											#is entered by the users in the browser
	within('#new-link') do
		fill_in 'url', :with => url
		fill_in 'title', :with => title
		fill_in 'tags', :with => tags.join(' ')
		click_button 'Add link'
	end
	
end

=end

