
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

    def run(stdin = $stdin)
      if not @tag
        @state = :error
        return
      end

      flow_handler = MrFlow::SimpleFlowHandler.new(URL)

      if @input
        handle_input_from_arg(flow_handler)
      elsif @stdin
        handle_input_from_stdin(flow_handler, stdin)
      else
        handle_output_to_stdout(flow_handler)
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

    private
    def handle_input_from_arg(flow_handler)
      @state = :input
      puts flow_handler.send(@tag, @input) unless @dummy
    end

    def handle_input_from_stdin(flow_handler, stdin = $stdin)
      @state = :input
      if not @dummy
        str = MrFlow::InputReader.new(stdin).gets
        puts flow_handler.send(@tag, str) unless str.empty?
      end
    end

    def handle_output_to_stdout(flow_handler)
      @state = :output
      puts flow_handler.receive(@tag) unless @dummy
    end
  end
end
