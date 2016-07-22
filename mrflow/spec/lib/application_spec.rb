require_relative "../../lib/application.rb"

describe MrFlow::Application do
  let(:dummy_arg) { [ "-d" ] }
  let(:t_arg) { [ "-d", "-t", "test-tag"] }
  let(:i_arg) { [ "-d", "-i", "test-data"] }
  let(:t_i_arg) { t_arg + i_arg }

  describe "argument parsing" do
    it "accepts a dummy argument so it does nothing for testing" do
      flow = MrFlow::Application.new(dummy_arg)
      flow.run
      expect(flow.dummy).to eq(true)
    end

    it "accepts a tag argument -t" do
      flow = MrFlow::Application.new(t_arg)
      flow.run
      expect(flow.tag).to eq(t_arg.last)
    end

    it "accepts an input argument -i "do
      flow = MrFlow::Application.new(i_arg)
      flow.run
      expect(flow.input).to eq(i_arg.last)
    end
  end

  describe "application states" do
    it "is put into output mode when given only a tag" do
      flow = MrFlow::Application.new(t_arg)
      flow.run
      expect(flow.state).to eq(:output)
    end

    it "is put into input mode when given a tag and an input" do
      flow = MrFlow::Application.new(t_i_arg)
      flow.run
      expect(flow.state).to eq(:input)
    end

    it "is put into error mode when given only an input" do
      flow = MrFlow::Application.new(i_arg)
      flow.run
      expect(flow.state).to eq(:error)
    end
  end
end
