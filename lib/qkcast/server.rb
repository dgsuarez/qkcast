require 'socket'
require 'rack'
require 'thor'
require 'qkcast/generator'

begin
  require 'thin'
  HANDLER = Rack::Handler::Thin
rescue LoadError
  begin
    require 'mongrel'
    HANDLER = Rack::Handler::Mongrel
  rescue LoadError
    HANDLER = Rack::Handler::WEBrick
  end
end

module Qkcast
  class Server < Thor

    desc "serve PATH", "generate rss in PATH and start serving"
    option :port
    option :ip
    def serve(path)
      ip = options[:ip] || UDPSocket.open {|s| s.connect("8.8.8.8", 1); s.addr.last}
      port = options[:port] || 3000
      url = "http://#{ip}:#{port}"
      rss = Qkcast::Generator.new(path, url).rss
      File.open(File.join(path, "feed.rss"), 'w') {|f| f << rss}
      puts "Add #{url}/feed.rss to your podcast player"
      Signal.trap('INT') { HANDLER.shutdown }
      HANDLER.run(Rack::Directory.new(path), :Port => port)
    end

  end
end
