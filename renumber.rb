#!/usr/bin/env ruby
# coding: utf-8

def usage
  puts <<EOF
usage: #{$0} dir
dir 中の *.jpg ファイルを 001 からの連番にリネームする。
EOF
  exit
end

# require 'logger'
# log = Logger.new("log/who-is-in.log", 5, 10*1024)
# log.level = Logger::DEBUG

usage unless ARGV.length == 1

Dir.chdir(ARGV[0]) do
  all = Dir.glob("*.jpg").sort
  ("0001".."9999").each do |name|
    f = all.shift
    if f.nil?
      break
    else
      File.rename(f,"#{name}.jpg")
    end
  end
end
