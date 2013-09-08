require 'pathname'
require 'erubis'

module Qkcast
  class Generator
    def initialize(path, url=nil)
      @path = path
      @url = url
    end

    def files
      Dir.glob(File.join(@path, "*.mp3")).sort
    end

    def items
      template = Erubis::Eruby.new(File.read "lib/templates/item.erb")
      self.files.map do |f|
        size = File.size(f)
        name = Pathname.new(f).basename.to_s
        template.result(:file => name, :size => size, :url => @url)
      end
    end

    def rss
      template = Erubis::Eruby.new(File.read "lib/templates/rss.erb")
      template.result(:items => self.items.join("\n"))
    end

  end
end
