require "rails_helper"
RSpec.describe "Grab a flow" do
  describe "valid" do
    describe "simple" do
      let(:existing_flow) { FactoryGirl.create(:flow, id: "test_tag", payload: "test_payload") }

      before :each do
        get flow_path(existing_flow.flow_tag), headers: { "ACCEPT" => "application/json" } 
      end

      it "returns OK" do 
        expect(response.status).to eq(200)
      end

      it "returns the flow data" do
        expect(response.body).to eq({ payload: existing_flow.payload }.to_json)
      end
    end
  end

  describe "invalid" do

  end
end
