
require "optparse"
require_relative "simple_flow_handler.rb"
require_relative "input_reader.rb"

URL = "http://localhost:3000/flows"

module MrFlow
  class Application
    attr_reader :tag, :input, :state, :dummy, :stdin

    def initialize(argv)
      @args = argv
      @state = :none
      @dummy = false
      parse_options(@args)
    end

    def run(stdin_input = $stdin)
      flow_handler = MrFlow::SimpleFlowHandler.new(URL)

      if not @tag
        @state = :error
        return
      end

      if @input
        @state = :input
        puts flow_handler.send(@tag, @input) unless @dummy
        return

      elsif @stdin
        @state = :input

        if not @dummy 
          str = MrFlow::InputReader.new(stdin_input).gets
          resp = flow_handler.send(@tag, str) unless str.empty?
        end
        return

      else
        @state = :output
        puts flow_handler.receive(@tag) unless @dummy
        return
      end
    end

    def parse_options(argv)
      parser = OptionParser.new do |opt|
        opt.on("-i", "--input INPUT") { |input| @input = input }
        opt.on("-s", "--stdin") { @stdin = true } 
        opt.on("-t", "--tag TAG") { |tag| @tag = tag }
        opt.on("-d", "--dummy") { @dummy = true }
      end
      parser.parse(argv)
    end
  end
end
