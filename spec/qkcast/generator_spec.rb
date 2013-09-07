require 'spec_helper'

describe Qkcast::Generator do

  it "should get a sorted list of mp3 from a path" do
    Qkcast::Generator.new("spec/files").files.should eql %w(a.mp3 b.mp3 c.mp3).map {|x| "spec/files/#{x}"}
  end

  it "should create a rss item for each file" do
    Qkcast::Generator.new("spec/files").items.should have(3).elements
    i = Qkcast::Generator.new("spec/files").items.first
    i.should =~ /<item>/
    i.should =~ /<\/item>/
  end

  it "should get the length for each file" do
    i = Qkcast::Generator.new("spec/files").items.first
    i.should =~ /enclosure.*length="0"/
  end

  it "should generate with the provided url" do
    i = Qkcast::Generator.new("spec/files", "http://example.com").items.first
    i.should =~ /enclosure url="http:\/\/example.com\/a.mp3"/
  end

  it "should generate the full rss" do
    rss = Qkcast::Generator.new("spec/files", "http://example.com").rss
    rss.should =~ /<rss/
    rss.should =~ /<\/rss/
  end

end
