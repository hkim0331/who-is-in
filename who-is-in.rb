#!/usr/bin/env ruby
require 'opencv'
include OpenCV

DEBUG = true

IMAGES_DIR = "./images/"

SLEEP  = 1000 # msec
POINTS = 100
THRES  = POINTS*1000

TEXT_X=10
TEXT_Y=50
TEXT_COLOR=CvColor::White
THICKNESS=3

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

  def save(im, dir, with_date)
    @num += 1
    dest = File.join(dir,format("%04d.jpg",@num))
    if with_date
      im = im.put_text(Time.now.to_s,
                       CvPoint.new(TEXT_X, TEXT_Y),
                       CvFont.new(:simplex,:thickness => THICKNESS),
                       TEXT_COLOR)
    end
    im.save_image(dest)
  end

  def close()
    @window.destroy
  end

end

def time_has_come?(at)
  Time.now.strftime("%T") >= at
end

#
# main starts here
#

if __FILE__ == $0
  exit_at = false
  with_date = false
  while arg = ARGV.shift
    case arg
    when /--reset-at/
      arg = argv.shift
      if arg =~ /\A\d\d:\d\d:\d\d\Z/
        exit_at = arg
      else
        raise "time format error: ${arg}"
      end
    when /--with-date/
      with_date=true
    else
      raise "unknown arg: #{arg}"
    end
  end
  app = App.new
  im0 = app.query
  while (true)
    im1 = app.query
    if app.diff?(im0,im1)
      app.save(im1, IMAGES_DIR, with_date)
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
