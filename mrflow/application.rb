
require "optparse"
require_relative "lib/simple_flow_handler.rb"

URL = "http://localhost:3000/flows"

module MrFlow
  class Application
    attr_reader :tag, :input, :output, :data, :stdin, :fake

    def initialize(argv)
      @args = argv
      parse_options(@args)
      handle_options
    end

    private
    def handle_options
      flow_handler = MrFlow::SimpleFlowHandler.new(URL)

      if @input and @data
        flow_handler.send(@tag, @data)
      elsif @output
        puts flow_handler.receive(@tag)
      end 
    end

    def parse_options(argv)
      parser = OptionParser.new do |opt|
        opt.on("-i", "--input") { @input = true }
        opt.on("-o", "--output") { @output = true }
        opt.on("-s", "--stdin") { @stdin = true }
        opt.on("-t", "--tag TAG") { |tag| @tag = tag }
        opt.on("-d", "--data DATA") { |data| @data = data }
        opt.on("-f", "--fake") { |fake| @fake = fake }
      end
      parser.parse(argv)
    end
  end
end
