require "rails_helper"

RSpec.describe "Create flow with JSON" do
  describe "valid" do
    describe "simple" do
      before :each do
        param = { payload: "test", flow_tag: "test", flow_type: :simple }
        post flows_path, params: param.to_json, headers: { "CONTENT_TYPE" => "application/json", 
                                                                "ACCEPT" => "application/json" } 
      end

      it "returns OK" do
        expect(response.status).to eq(200)
      end

      it "returns the id and tag" do
        json = JSON.parse(response.body)
        expect(json["id"]).to be_a(Integer)
        expect(json["flow_tag"]).to eq("test")
      end
    end
  end

  describe "invalid" do
    it "returns an error" do
        param = { payload: "test", flow_tag: "test", flow_type: :simple }
        post flows_path, params: param.to_json, headers: { "CONTENT_TYPE" => "application/json", 
                                                                "ACCEPT" => "application/json" } 

    end
  end
end
