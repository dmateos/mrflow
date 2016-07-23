require_relative "../../lib/input_reader.rb"

describe MrFlow::InputReader do
  let(:fake_stdin) { double() }
  subject { MrFlow::InputReader.new(fake_stdin) }

  describe "reads input" do
    it "#gets - read from input that has a gets interface" do
      expect(fake_stdin).to receive(:gets).and_return("fake")
      expect(fake_stdin).to receive(:gets).and_return(false)
      expect(subject.gets).to eq("fake")
    end
  end
end
