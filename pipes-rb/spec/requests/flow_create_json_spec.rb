require "rails_helper"

RSpec.describe "Create flow with JSON" do
  let(:header) { { "CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json" } }
  let(:param) { { payload: "test", flow_tag: "test", flow_type: :simple } }

  describe "valid" do
    describe "simple" do
      before :each do
        post flows_path, params: param.to_json, headers: header 
      end

      it "returns OK" do
        expect(response.status).to eq(200)
      end

      it "returns the id and tag" do
        json = JSON.parse(response.body)
        expect(json["id"]).to be_a(Integer)
        expect(json["flow_tag"]).to eq(param[:payload])
      end
    end
  end

  describe "invalid" do
    describe "simple" do 
      it "returns an error" do
          post flows_path, params: param.to_json, headers: header
      end
    end
  end
end
