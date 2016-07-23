require "rails_helper"
RSpec.describe "Grab a flow" do
  let(:header) { { "ACCEPT" => "application/json" } }

  describe "valid" do
    describe "simple" do
      let(:existing_flow) { FactoryGirl.create(:flow, id: "test_tag", payload: "test_payload") }

      before :each do
        get flow_path(existing_flow.flow_tag), headers: header 
      end

      it "returns OK" do 
        expect(response.status).to eq(200)
      end

      it "returns SUCCESS in json" do
        resp = JSON.parse(response.body)
        expect(resp["success"]).to eq(true)
      end

      it "returns the flow data" do
        resp = JSON.parse(response.body)
        expect(resp["payload"]).to eq(existing_flow.payload)
      end
    end
  end

  describe "invalid tag" do
    describe "simple" do
      before :each do 
        get flow_path("unknown-tag"), headers: header
      end

      it "returns 404 for an invalid tag" do
        expect(response.status).to eq(404)
      end

      it "returns NOT SUCCESS in json" do 
        resp = JSON.parse(response.body)
        expect(resp["success"]).to eq(false)
      end

      it "returns an error in json" do 
        resp = JSON.parse(response.body)
        expect(resp["error"]).to eq("flow not found")
      end
    end
  end
end
