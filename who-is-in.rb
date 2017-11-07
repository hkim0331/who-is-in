#!/usr/bin/env ruby
require 'logger'
require 'opencv'
include OpenCV

DEBUG = true
VERSION = "0.6.2"

IMAGES_DIR = "./images"

POINTS = 100

THRES_SD2   = 10
THRES_DIFF2 = 50*POINTS

TEXT_X = 10
TEXT_Y = 50
TEXT_COLOR = CvColor::White
THICKNESS = 3

def usage(s)
  print <<EOF
#{s}
#{$0} [--debug]
      [--without-date]
      [--without-jpg2mp4]
      [--headless]
      [--exit-at hh:mm:ss]
      [--exit-after sec]
      [--reset-at hh:mm:ss]
      [--log logfile]
      [--version]

without --without-jpg2mp4 option,
converts captured jpgs into mp4 movie 'out.mp4'.

./slow.sh makes 'out.mp4' slow to 'slow.mp4'.
which is convenient to replay.

qt-rate.scpt is a spimle QuickTime replay rate changer.

with --exit-at or --exit-after option, captured image does not display
on the screen during who-is-in execution. headless mode.

with --rest-at, images/*.jpg files are cleared. also numbers to jpg files
will be reset.

EOF
  exit(0)
end

def sd2(xs)
  length  = xs.length
  mean = xs.inject(:+)/length
  xs.map{|x| (x-mean)*(x-mean)}.inject(:+)/length
end

class App
  attr_reader :points

  def initialize(fps, width, height, headless, logfile)
    @window = GUI::Window.new("who is in?") unless headless
    @cam = CvCapture.open(0)
    @cam.width= width
    @cam.height= height
    @cam.fps= fps
    im = self.query
    width, height  = im.width, im.height
    @points = Array.new(POINTS).map{|x| [rand(width), rand(height)]}
    @num = 0
    Dir.glob("#{IMAGES_DIR}/*").map{|f| File.unlink(f)}

    system("touch #{logfile}")
    @log = Logger.new(logfile)
    @log.level = if $DEBUG
                   Logger::DEBUG
                 else
                   Logger::INFO
                 end
  rescue
    puts "can not open cam. check the connection."
    exit(1)
  end

  def query
    im = nil
    while im.nil?
      im = @cam.query
      print "x" if im.nil? if $DEBUG
    end
    print "." if $DEBUG
    im
  end

  def show(m)
    @window.show(m)
  end

  def rgb2gray(pic)
    r,g,b = pic
    0.299*r + 0.587*g + 0.144*b
  end

  def diff?(im0, im1)
    @mean  = (@points.map{|p| y,x = p; rgb2gray(im1[x,y])}.inject(:+)/POINTS).floor
    @sd2   = (sd2(@points.map{|p| y,x = p; rgb2gray(im0[x, y]) - rgb2gray(im1[x,y])})/POINTS).floor
    @diff2 = (@points.map{|p| y,x = p; (im0[x,y] - im1[x,y]).to_a.map{|z| z*z}}.flatten.inject(:+)/POINTS).floor
    @log.debug("mean: #{@mean} sd2: #{@sd2} diff2: #{@diff2}")
    (@sd2 > THRES_SD2) and (@diff2 > THRES_DIFF2)
  end

  def save(im, dir, with_date)
    @num += 1
    dest = File.join(dir,format("%04d.jpg", @num))
    if with_date
      im.put_text!(Time.now.to_s,
                   CvPoint.new(TEXT_X, TEXT_Y),
                   CvFont.new(:simplex,:thickness => THICKNESS),
                   TEXT_COLOR)
      if true
        im.put_text!(@mean.to_s,
                     CvPoint.new(TEXT_X, TEXT_Y+50),
                     CvFont.new(:simplex,:thickness => THICKNESS),
                     TEXT_COLOR)
        im.put_text!(@sd2.to_s,
                     CvPoint.new(TEXT_X, TEXT_Y+100),
                     CvFont.new(:simplex,:thickness => THICKNESS),
                     TEXT_COLOR)
        im.put_text!(@diff2.to_s,
                     CvPoint.new(TEXT_X, TEXT_Y+150),
                     CvFont.new(:simplex,:thickness => THICKNESS),
                     TEXT_COLOR)
      end
    end
    im.save_image(dest)
    print "c" if $DEBUG
  end

  def reset
    system("rm -f images/*.jpg")
    @num = 0
  end

  def close()
    @window.destroy if @window
  end

end

def time_is?(at)
  Time.now.strftime("%T") == at
end

def time_has_come?(at)
  Time.now.strftime("%T") >= at
end

def do_jpg2mp4()
  unless Dir.glob("images/*.jpg").empty?
    system("ffmpeg -y -f image2 -i images/%04d.jpg -framerate 1 out.mp4")
  end
end

#
# main starts here
#

if __FILE__ == $0
  $DEBUG    = false
  exit_at   = false
  reset_at  = false
  with_date = true
  jpg2mp4   = true
  headless  = false
  log = "log/who-is-in.log"

  fps = 1.0
  width = 640
  height = 360

  while arg = ARGV.shift
    case arg
    when /--debug/
      $DEBUG = true
    when /--fps/
      fps = ARGV.shift.to_r
    when /--width/
      width = ARGV.shift.to_i
    when /--height/
      height = ARGV.shift.to_i
    when /--headless/
      headless = true
    when /--exit-at/
      arg = ARGV.shift
      if arg =~ /\A\d\d:\d\d:\d\d\Z/
        exit_at = arg
      else
        raise "time format error: ${arg}"
      end
    when /--reset-at/
      arg = ARGV.shift
      if arg =~ /\A\d\d:\d\d:\d\d\Z/
        reset_at = arg
      else
        raise "time format error: ${arg}"
      end
    when /--exit-after/
      exit_at = (Time.now + ARGV.shift.to_i).strftime("%T")
    when /--without-date/
      with_date = false
    when /--without-jpg2mp4/
      jpg2mp4 = false
    when /--log/
      log = ARGV.shift
    when /--version/
      puts VERSION
      exit(0)
    when /--/
      usage "usage:"
    else
      usage "unknown arg: #{arg}"
    end
  end

  if $DEBUG
    puts "start: #{Time.now.strftime('%T')}"
    puts "end: #{exit_at}"
    puts "fps: #{fps}"
    puts "width: #{width}"
  end

  app = App.new(fps, width, height, headless, log)
  im0 = app.query
  app.save(im0, IMAGES_DIR, with_date)
  while (true)
    im1 = app.query
    app.show(im1) unless headless
    if app.diff?(im0, im1)
      app.save(im1, IMAGES_DIR, with_date)
      im0 = im1
    end

    if exit_at and time_has_come?(exit_at)
      break
    end

    if reset_at and time_is?(reset_at)
      do_jpg2mp4() if jpg2mp4
      app.reset()
      sleep(61)
    end

    if headless
      sleep(1.0/fps)
    else
      puts "headless: #{headless}"
      GUI::wait_key((1000/fps).to_i)
    end

  end

  do_jpg2mp4() if jpg2mp4
  app.close()

end
