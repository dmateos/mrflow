
require "optparse"
require_relative "simple_flow_handler.rb"

URL = "http://localhost:3000/flows"

module MrFlow
  class Application
    attr_reader :tag, :input, :state, :dummy

    def initialize(argv)
      @args = argv
      @state = :none
      @dummy = false
      parse_options(@args)
    end

    def run
      flow_handler = MrFlow::SimpleFlowHandler.new(URL)

      if @tag and not @input
        @state = :output
        puts flow_handler.receive(@tag) if not @dummy
      elsif @tag and @input
        @state = :input
        flow_handler.send(@tag, @input) if not @dummy
      else
        @state = :error
      end 
    end

    def parse_options(argv)
      parser = OptionParser.new do |opt|
        opt.on("-i", "--input INPUT") { |input| @input = input }
        opt.on("-t", "--tag TAG") { |tag| @tag = tag }
        opt.on("-d", "--dummy") { @dummy = true }
      end
      parser.parse(argv)
    end
  end
end
