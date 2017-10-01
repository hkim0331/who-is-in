#!/usr/bin/env ruby
require 'opencv'
include OpenCV

DEBUG = true

IMAGES = "./images/"
SLEEP  = 1000 # msec
POINTS = 100
THRES  = POINTS*1000

class App
  attr_reader :points

  def initialize
    @window = GUI::Window.new("who is in?")
    @cam = CvCapture.open(0)
    im = @cam.query
    width, height  = im.width, im.height
    @points = Array.new(POINTS).map{|x| [rand(width),rand(height)]}
    @num = 0
  end

  def query
    @cam.query
  end

  def show(m)
    @window.show(m)
  end

  def diff?(im0,im1)
    @points.map{|p| y,x = p; (im0[x,y]-im1[x,y]).to_a.map{|z| z*z}}.
      flatten.inject(:+) > THRES
  end

  def save(im, dir = IMAGES)
    @num += 1
    im.save_image(File.join(dir, format("%04d.jpg",@num)))
  end

  def close()
    @window.destroy
  end

end

def headless?(argv)
  while arg = argv.shift
    case arg
      when /--exit-at/
        arg = argv.shift
        if arg =~ /\A\d\d:\d\d:\d\d\Z/
          return arg
        else
          raise "time format error: ${arg}"
        end
      else
        raise "unknown arg: #{arg}"
      end
  end
  false
end

def time_has_come?(at)
  Time.now.strftime("%T") >= at
end

#
# main starts here
#

if __FILE__ == $0
  exit_at = headless?(ARGV)
  app = App.new
  im0 = app.query
  while (true)
    im1 = app.query
    if app.diff?(im0,im1)
      app.save(im1)
      app.show(im1) unless exit_at
      im0 = im1
    end
    if exit_at
      break if time_has_come?(exit_at)
      sleep(SLEEP/1000.0)
    else
      break if GUI::wait_key(SLEEP)
    end
  end
  app.close()
end
