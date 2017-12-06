#!/usr/bin/env ruby
# coding: utf-8

def usage
  puts <<EOF
usage:
{$0} from-dir dest-dir

from-dir 中の *.jpg ファイルを逆順の名前に変えて dest-dir に移動する。
EOF
  exit
end

require 'logger'
log = Logger.new("log/who-is-in.log", 5, 10*1024)
log.level = Logger::DEBUG

if (ARGV.length==2)
  from = ARGV[0]
  dest = ARGV[1]
else
  usage
end

orig = Dir.glob("#{from}/*.jpg").sort
rev = orig.reverse.map{ |x| x.sub(/#{from}/, dest) }

orig.each do |o|
  to = rev.shift
  File.rename(o, to)
  log.debug("copied from #{from} to #{to}")
end

