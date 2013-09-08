require 'socket'
require 'rack'

module Qkcast
  class Server

    def serve(path, opts={})
      ip = opts["ip"] || Socket.ip_address_list.detect{|intf| intf.ipv4? and !intf.ipv4_loopback? and !intf.ipv4_multicast? and !intf.ipv4_private?}
      pot = opts["port"] || 3000
      url = "http://#{ip}:#{port}"
      rss = Qkcast::Generator.new(path, url).rss
      File.open(File.join(path, "feed.rss"), 'w') {|f| f << rss}
      Rack::Handler::Webrick.run(Rack::Directory.new(path), :port => port)
    end

  end
end
