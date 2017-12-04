#!/usr/bin/env ruby
orig = Dir.glob("images/*.jpg")
rev = orig.reverse.map{ |x| x.sub(/images/,"reverse")}
orig.each do |from|
  to = rev.shift
	File.rename(from, to)
end
