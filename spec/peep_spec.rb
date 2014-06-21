describe Peep do

	# context "" do

		it "has a content" do
			peep = Peep.create(content: "The thoughts of John Apple")
			expect(Peep.count).to eq 1
			expect(peep.content).to eq "The thoughts of John Apple"
		end


		it "must have content" do
			Peep.create
			expect(Peep.count).to eq 0
		end

		it "is created with a time stamp" do
			peep = Peep.create(content: "The thoughts of John Apple")
			expect(peep.time).not_to be_nil
		end
end

