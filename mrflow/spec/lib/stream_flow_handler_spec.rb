require_relative "../../lib/stream_flow_handler.rb"

describe MrFlow::StreamFlowHandler do
  let(:fake_websocket) { double() } 
  let(:host) { "ws://localhost:8888" }
  let(:tag) { "tag" } 

  subject { MrFlow::StreamFlowHandler.new(host, fake_websocket) }

  describe "#connect - flow connection" do
    it "sets connected on a valid connection" do
      expect(fake_websocket).to receive(:connect).with(host)
      expect(fake_websocket).to receive(:on).with(:open).and_yield
      subject.connect
      expect(subject.connected).to eq(true)
    end

    it "does not set connected on an invalid connection" do
      expect(fake_websocket).to receive(:connect).with(host)
      expect(fake_websocket).to receive(:on).with(:open)
      subject.connect
      expect(subject.connected).to eq(false)
    end
  end

  describe "#send - flow sending" do

  end

  describe "#receive - flow receiving" do

  end
end
