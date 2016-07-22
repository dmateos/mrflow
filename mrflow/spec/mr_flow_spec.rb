require_relative "../application.rb"

describe MrFlow::Application do
  describe "argument parsing" do
    it "accepts a tag with -t or --tag" do
      expect(MrFlow::Application.new(["--tag", "test"]).tag).to eq("test")
    end

    it "accepts an input request with -i or --input" do
      expect(MrFlow::Application.new(["--input"]).input).to eq(true)
    end

    it "accepts an output request with -o or --output" do
      expect(MrFlow::Application.new(["--output"]).output).to eq(true)
    end

    it "accepts a data input with -d or --data" do
      expect(MrFlow::Application.new(["--data", "test"]).data).to eq("test")
    end 

    it "accepts the std data input option" do 
      expect(MrFlow::Application.new(["--stdin"]).stdin).to eq(true)

    end
  end

  describe "input gathering" do
    it "is able to grab input via the --data param" do
      expect(MrFlow::Application.new(["--data", "test"]).data).to eq("test")
    end

    it "is able to gather input via stdin" do

    end
  end

  describe "input processing" do
    it "pushes data from a data argument" do

    end

    it "streams data from stdin" do

    end
  end

  describe "output processing" do
    it "pulls data for a given tag" do

    end

    it "streams data for a given tag" do

    end
  end
end
