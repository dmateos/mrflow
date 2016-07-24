require_relative "../../lib/simple_flow_handler.rb"

describe MrFlow::SimpleFlowHandler do
  let(:fake_http) { double() }
  let(:host) { "http://localhost/flows" }
  let(:tag) { "tag" }

  let(:recv_payload) { { "success" => true, "payload" => "test-data" } }
  let(:send_payload) { { "success" => true, "id" => 001, "flow_tag" => "test-tag" } }

  let(:recv_error_payload) { { "success" => false, "error" => "flow not found" } }
  let(:send_error_payload) { { "success" => false, "error" => "some error" } }

  subject { MrFlow::SimpleFlowHandler.new(host, fake_http) }

  describe "#send - flow sending" do
    it "builds the correct url and sends the correct data to the flow" do
      expect(fake_http).to receive(:post).with("#{host}", anything).and_return(send_payload)
      expect(subject.send(tag, "test")).to be_a(Integer)
    end

    it "handles flow server returning an error with the request" do
      expect(fake_http).to receive(:post).with("#{host}", anything).and_return(send_error_payload)
      expect(subject.send(tag, "test")).to eq(send_error_payload["error"])
    end
  end

  describe "#receive - flow receiving" do 
    it "builds the correct url and returns a flow based on a tag" do
      expect(fake_http).to receive(:get).with("#{host}/#{tag}", anything).and_return(recv_payload)
      expect(subject.receive(tag)).to eq(recv_payload["payload"])
    end

    it "handles flow server returning an error with the request (no existing tag)" do
      expect(fake_http).to receive(:get).with("#{host}/#{tag}", anything).and_return(recv_error_payload)
      expect(subject.receive(tag)).to eq(recv_error_payload["error"])
    end
  end
end
