feature "Peep" do

	scenario "has content" do
		sign_up
		fill_in :peep_content, with: "The thoughts of Test User"
		click_button("Submit")
		expect(Peep.count).to eq 1
	end

	scenario "must have content" do
		Peep.create
		expect(Peep.count).to eq 0
	end

	scenario "is created with a time stamp" do
		peep = Peep.create(content: "The thoughts of Test User")
		expect(peep.time).not_to be_nil
	end
end

