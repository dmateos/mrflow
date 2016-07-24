require_relative "http_wrapper.rb"
require "json"

module MrFlow
  class SimpleFlowHandler
    def initialize(server = "http://localhost/flows", transport = HTTPWrapper)
      @server = server
      @transport = transport
    end

    def send(tag, data)
      begin
        resp = @transport.post("#{@server}", send_json(tag, data))

        if resp["success"] and resp["id"]
          return resp["id"]
        elsif resp["error"]
          return resp["error"]
        end

      rescue Errno::ECONNREFUSED
        "connection refused"
      end
    end

    def receive(tag)
      begin
        resp = @transport.get("#{@server}/#{tag}", json_headers)

        if resp["success"] and resp["payload"]
          return resp["payload"]
        elsif resp["error"]
          return resp["error"]
        end 

      rescue Errno::ECONNREFUSED
        "connection refused"
      end
    end

    private
    def json_headers
      {
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        }
      }
    end

    def send_json(tag, data)
      { 
        body: { 
          flow: { 
            flow_tag: tag,
            payload: data,
            flow_type: :simple
          }
        }.to_json
      }.merge(json_headers)
    end
  end
end
