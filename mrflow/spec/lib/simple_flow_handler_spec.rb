require_relative "../../lib/simple_flow_handler.rb"

describe MrFlow::SimpleFlowHandler do
  let(:fake_http) { double() }
  let(:host) { "http://localhost/flows" }
  let(:tag) { "tag" }
  let(:payload) { { "success" => true, "payload" => "test-data" } }
  let(:error_payload) { { "success" => false, "error" => "flow not found" } }

  subject { MrFlow::SimpleFlowHandler.new(host, fake_http) }

  describe "#send - flow sending" do
    it "builds the correct url and sends the correct data to the flow" do
      expect(fake_http).to receive(:post).with("#{host}", anything).and_return(true)
      expect(subject.send(tag, payload["payload"])).to eq(true)
    end

    it "handles flow server returning an error with the request" do
      
    end
  end

  describe "#receive - flow receiving" do 
    it "builds the correct url and returns a flow based on a tag" do
      expect(fake_http).to receive(:get).with("#{host}/#{tag}", anything).and_return(payload)
      expect(subject.receive(tag)).to eq(payload["payload"])
    end

    it "handles flow server returning an error with the request (no existing tag)" do
      expect(fake_http).to receive(:get).with("#{host}/#{tag}", anything).and_return(error_payload)
      expect(subject.receive(tag)).to eq(error_payload["error"])
    end
  end
end
