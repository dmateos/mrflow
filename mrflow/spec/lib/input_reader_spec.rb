require_relative "../../lib/input_reader.rb"

describe MrFlow::InputReader do
  let(:fake_stdin) { double() }
  subject { MrFlow::InputReader.new(fake_stdin) }

  describe "#gets reads input" do
    it "read from input that has a gets interface" do
      expect(fake_stdin).to receive(:gets).and_return("fake")
      expect(fake_stdin).to receive(:gets).and_return(false)
      expect(subject.gets).to eq("fake")
    end

    it "concatinates multiple iterations" do
      expect(fake_stdin).to receive(:gets).and_return("fake")
      expect(fake_stdin).to receive(:gets).and_return(" fake")
      expect(fake_stdin).to receive(:gets).and_return(false)
      expect(subject.gets).to eq("fake fake")
    end
  end
end
