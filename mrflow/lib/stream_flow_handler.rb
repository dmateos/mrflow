require "rubygems"
require "websocket-client-simple"

module MrFlow
  class StreamFlowHandler
    attr_reader :connected

    def initialize(server = "ws://localhost:8888", transport = WebSocket::Client::Simple)
      @server = server
      @transport = transport
      @connected = false
    end

    def connect
      @transport.connect(@server)
      @transport.on :open do
        @connected = true
      end
    end

    def send(data)
      @transport.send(data)
    end
  end
end
