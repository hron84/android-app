#!/usr/bin/env ruby

require 'open-uri'
require 'rexml/document'
require 'digest/sha1'

include REXML

REPOXML_PATH = "https://dl-ssl.google.com/android/repository/repository.xml"

doc = Document.new open(REPOXML_PATH)

doc.root.elements.each('//sdk:platform-tool/sdk:archives/sdk:archive[@os="macosx"]') do |elem|
  children = elem.elements.to_a
  url = children.find { |el| el.name == 'url' }.text
  checksum = children.find { |el| el.name == 'checksum' }.text

  if ARGV.shift == '-n'
    puts url
    exit
  end

  dlurl = "https://dl-ssl.google.com/android/repository/#{url}"
  File.open(url, 'w') do |fp|
    fp.write open(dlurl).read
  end
  
  digest = Digest::SHA1.hexdigest(File.read(url))
  unless digest == checksum
    $stderr.puts "SDK is down, but seems corrupt!"
    $stderr.puts "Actual: #{digest}, expected: #{checksum}"
    exit 1
  end

  exit
end
