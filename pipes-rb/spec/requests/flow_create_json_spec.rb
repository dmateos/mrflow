require "rails_helper"

RSpec.describe "Create flow with JSON" do
  let(:header) { { "CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json" } }
  let(:param) { { payload: "test", flow_tag: "test", flow_type: :simple } }

  describe "valid" do
    describe "simple" do
      before :each do
        post flows_path, params: param.to_json, headers: header 
        @json = JSON.parse(response.body)
      end

      it "returns OK" do
        expect(response.status).to eq(200)
      end

      it "returns SUCCESS in JSON response" do
        expect(@json["success"]).to eq(true)
      end

      it "returns the id in JSON response" do
        expect(@json["id"]).to be_a(Integer)
      end

      it "returns the tag in JSON response" do
        expect(@json["flow_tag"]).to eq(param[:payload])
      end
    end
  end

  describe "invalid" do
    describe "simple" do 
      let!(:duplicate) { FactoryGirl.create(:flow, flow_tag: param[:flow_tag]) } 

      before :each do
          post flows_path, params: param.to_json, headers: header
          @json = JSON.parse(response.body)
      end

      it "returns 404" do
        expect(response.status).to eq(404)
      end

      it "returns NOT SUCCESS in JSON response" do
        expect(@json["success"]).to eq(false)
      end

      it "returns an error in JSON response" do
        expect(@json["error"]).to_not eq(nil)
      end
    end
  end
end
