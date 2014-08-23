describe "Users & Peeps ", type: :feature, js: true do

	it "users can see the list of previous peeps if not signed-in" do
		user_create_peep
		expect(page).to have_content "The thoughts of Test User"
	end

	it "users can see the list of previous peeps if signed-in" do
		user_create_peep
		sign_in
		field = find_field(id="peep_content",type="textarea").value
		expect(field).to be_empty
		expect(page).to have_content "The thoughts of Test User"
	end

	it "users can access the 'add new peep' section while being signed-in" do
		sign_up
		expect(page).to have_button "Submit"
		expect(page).to have_field(id="peep_content",type="textarea")
	end

	it "users can post a new peep while being signed-in" do
		sign_up
		fill_in :peep_content, with: "The thoughts of Test User"
		click_button "Submit"
		expect(page).to have_content "Thanks TU, peep posted!"
	end

	it "users cannot post a new peep if not signed-in" do
		visit "/"
		expect(page).not_to have_field(id="peep_content",type="textarea")
	end
	
	it "users cannot post an empty peep" do
		sign_up
		click_button "Submit"
		expect(page).not_to have_content "Thanks TU, peep posted!"
	end
end

