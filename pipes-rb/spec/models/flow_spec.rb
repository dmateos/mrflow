require 'rails_helper'

RSpec.describe Flow, type: :model do
  describe "validation" do
    it "requires a payload to exist" do
      expect(FactoryGirl.build(:flow, payload: nil)).to_not be_valid
    end

    it "requires a flow tag to exist" do
      expect(FactoryGirl.build(:flow, flow_tag: nil)).to_not be_valid
    end

    it "wont accept a duplicate flow tag" do
      record_one = FactoryGirl.create(:flow, flow_tag: "test")
      expect(FactoryGirl.build(:flow, flow_tag: "test")).to_not be_valid
    end

    it "requires a valid flow type to exist" do
      expect { FactoryGirl.build(:flow, flow_type: :unknown) }.to raise_error(ArgumentError)
    end

    it "saves when all the validations are correct" do
      expect(FactoryGirl.build(:flow)).to be_valid
    end

    it "saves multiple when all the validations are correct" do
      expect(FactoryGirl.build(:flow)).to be_valid
      expect(FactoryGirl.build(:flow, flow_tag: "new")).to be_valid
    end
  end
end
