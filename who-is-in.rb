#!/usr/bin/env ruby
require 'opencv'
include OpenCV

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
    width = im.width
    height = im.height
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
    dest = File.join(dir,format("%04d.jpg",@num))
    im.save_image(dest)
  end

  def close()
    @window.destroy
  end

end

# FIXME: 脱出のオプションも一緒にチェックすること。不完全。
def headless?(argv)
  while arg = argv.shift
    return true if arg =~ /--headless/
  end
  false
end

if __FILE__ == $0
  preview = true
  if headless?(ARGV)
    preview = false
  end
  app = App.new
  im0 = app.query
  while (true)
    im1 = app.query
    if app.diff?(im0,im1)
      app.save(im1)
      app.show(im1) if preview
      im0 = im1
    end
    break if GUI::wait_key(SLEEP)
  end
  app.close()
end
