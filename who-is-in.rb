#!/usr/bin/env ruby
require 'opencv'
include OpenCV

SLEEP  = 1000 # msec
POINTS = 10
THRES  = 10000
IMAGES = "./images"

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

  # FIXME! not smart.
  def diff?(im0,im1)
    d = 0
    @points.each do |pt|
      x,y = pt
      d += (im0[y,x]-im1[y,x]).to_a.map{|z| z*z}.inject(:+)
    end
    d > THRES
  end

  def save(im, dir=IMAGES)
    @num += 1
    puts "#{Time.now} changed, will save as #{@num}.jpg"
    im.save_image(File.expand_path(dir,"#{@num}.jpg"))
  end
end
#
# main starts here
#
if __FILE__ == $0
  app = App.new
  p app.points
  im0 = app.query

  while (true)
    im1 = app.query
    if app.diff?(im0,im1)
      app.save(im1)
      app.show(im1)
      im0 = im1
    end
    break if GUI::wait_key(SLEEP)
  end
end

