require_relative "../../lib/application.rb"

describe MrFlow::Application do
  describe "argument parsing" do
    it "accepts a tag argument -t" do
      flow = MrFlow::Application.new(["-t", "test-tag"])
      flow.run
      expect(flow.tag).to eq("test-tag")
    end

    it "accepts an input argument -i "do 
      flow = MrFlow::Application.new(["-i", "test-data"])
      flow.run
      expect(flow.input).to eq("test-data")
    end
  end

  describe "application states" do
    it "is put into output mode when given only a tag" do
      flow = MrFlow::Application.new(["-t", "test-tag"])
      flow.run
      expect(flow.state).to eq(:output)
    end

    it "is put into input mode when given a tag and an input" do
      flow = MrFlow::Application.new(["-t", "test-tag", "-i", "test"])
      flow.run
      expect(flow.state).to eq(:input)
    end

    it "is put into error mode when given only an input" do
      flow = MrFlow::Application.new(["-i", "test"])
      flow.run
      expect(flow.state).to eq(:error)
    end
  end
end
