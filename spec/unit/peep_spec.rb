
describe "Peep" do

	it "has content" do
		create_peep
		expect(Peep.first.content).to eq "The thoughts of Test User"
	end

	it "must have content" do
		create_peep "14:00","",1
		expect(Peep.count).to eq 0
	end

	it "is created with a time stamp" do
		create_peep
		expect(Peep.first.time).not_to be_nil
	end
end

