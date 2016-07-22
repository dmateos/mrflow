require_relative "../../lib/simple_flow_handler.rb"

describe MrFlow::SimpleFlowHandler do
  let(:fake_http) { double() }
  let(:host) { "http://localhost/flows" }
  let(:tag) { "tag" }
  let(:pl) { { "payload" => "test-data" } }
  subject { MrFlow::SimpleFlowHandler.new(host, fake_http) }

  describe "flow sending" do
    it "builds the correct url and sends the correct data to the flow" do
      expect(fake_http).to receive("post").with("#{host}", anything).and_return(true)
      expect(subject.send(tag, "test-data")).to eq(true)
    end
  end

  describe "flow receiving" do 
    it "builds the correct url and returns a flow based on a tag" do
      expect(fake_http).to receive("get").with("#{host}/#{tag}", anything).and_return(pl)
      expect(subject.receive(tag)).to eq(pl["payload"])
    end
  end
end
