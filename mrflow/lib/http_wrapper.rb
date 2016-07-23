require "net/http"

# We can party like HTTParty
module HTTPWrapper
  def self.get(uri, options)
    do_request(:get, uri, options)
  end

  def self.post(uri, options)
    do_request(:post, uri, options)
  end

  private
  def self.do_request(type, uri, options)
    uri = URI(uri)

    case type
    when :get
      request = Net::HTTP::Get.new(uri.path)
    when :post
      request = Net::HTTP::Post.new(uri.path)
      request.body = options[:body] if options[:body]
    end

    options[:headers].each { |k, v| request[k.to_s] = v.to_s }

    result = Net::HTTP.start(uri.hostname, uri.port) do |http|
      http.request(request)
    end

    result.body ? JSON.parse(result.body) : false
  end
end
