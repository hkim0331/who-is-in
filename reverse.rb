#!/usr/bin/env ruby

require 'Logger'
log = Logger.new("log/who-is-in.log", 5, 10*1024)
log.level = Logger::DEBUG

orig = Dir.glob("images/*.jpg")
rev = orig.reverse.map{ |x| x.sub(/images/,"reverse")}

# NO?
orig.each do |from|
  to = rev.shift
  File.rename(from, to)
  log.debug("copied from #{from} to #{to}")
end

# while (from = orig.shift)
#   to = rev.shift
#   File.rename(from, to)
# end
