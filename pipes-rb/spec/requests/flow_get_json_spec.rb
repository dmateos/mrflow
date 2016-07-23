require "rails_helper"
RSpec.describe "Grab a flow" do
  let(:header) { { "ACCEPT" => "application/json" } }

  describe "valid" do
    describe "simple" do
      let(:existing_flow) { FactoryGirl.create(:flow, id: "test_tag", payload: "test_payload") }

      before :each do
        get flow_path(existing_flow.flow_tag), headers: header 
        @json = JSON.parse(response.body)
      end

      it "returns OK" do 
        expect(response.status).to eq(200)
      end

      it "returns SUCCESS in JSON response" do
        expect(@json["success"]).to eq(true)
      end

      it "returns the flow data in JSON response" do
        expect(@json["payload"]).to eq(existing_flow.payload)
      end
    end
  end

  describe "invalid tag" do
    describe "simple" do
      before :each do 
        get flow_path("unknown-tag"), headers: header
        @json = JSON.parse(response.body)
      end

      it "returns 404" do
        expect(response.status).to eq(404)
      end

      it "returns NOT SUCCESS in JSON response" do 
        expect(@json["success"]).to eq(false)
      end

      it "returns an error in JSON response" do 
        expect(@json["error"]).to eq("flow not found")
      end
    end
  end
end
