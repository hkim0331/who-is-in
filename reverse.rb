#!/usr/bin/env ruby
orig = Dir.glob("images/*.jpg")
rev = orig.reverse.map{ |x| x.sub(/images/,"reverse")}

# NO?
# orig.each do |from|
#   to = rev.shift
#   File.rename(from, to)
# end

while (from = orig.shift)
  to = rev.shift
  File.rename(from, to)
end
