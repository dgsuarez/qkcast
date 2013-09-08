require 'pathname'
require 'cgi'
require 'erubis'

module Qkcast
  class Generator
    def initialize(path, url=nil)
      @path = path
      @url = url
    end

    def path_to_templates
      File.join(File.dirname(File.expand_path(__FILE__)), '../templates/')
    end

    def files
      Dir.glob(File.join(@path, "*.mp3")).sort
    end

    def items
      template = Erubis::Eruby.new(File.read File.join(self.path_to_templates, "item.erb"))
      self.files.map do |f|
        size = File.size(f)
        name = Pathname.new(f).basename.to_s
        escaped_name = CGI.escape(name)
        item_url = "#{@url}/#{escaped_name}"
        template.result(:name => name, :size => size, :url => item_url)
      end
    end

    def rss
      template = Erubis::Eruby.new(File.read File.join(self.path_to_templates, "rss.erb"))
      template.result(:items => self.items.join("\n"))
    end

  end
end
