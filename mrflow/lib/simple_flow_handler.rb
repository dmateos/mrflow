require "httparty"

module MrFlow
  class SimpleFlowHandler
    def initialize(server = "http://localhost/flows", transport = HTTParty)
      @server = server
      @transport = transport
    end

    def send(tag, data)
      @transport.post("#{@server}", send_json(tag, data))
    end

    def receive(tag)
      @transport.get("#{@server}/#{tag}", json_headers)["payload"]
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
