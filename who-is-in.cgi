#!/usr/bin/env ruby
#-*-coding: utf-8 -*-

IMAGES="images"
print <<EOH
content-type: text-html

<html>
<head>
<!-- Bootstrap core CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css" integrity="sha384-/Y6pD6FV/Vv2HJnA6t+vslU6fwYXjCFtcEpHbNJ0lyAFsXTsjBbfaDjzALeQsN6M" crossorigin="anonymous">
<!-- Custom styles for this template -->
<link href="who-is-in.css" rel="stylesheet">
</head>
<body>
<div class='container'>
<h1>WHO IS IN?</h1>

<h2>current</h2>
<p>
<img src="#{IMAGES}/current-1.jpg" width="300">
<img src="#{IMAGES}/current.jpg" width="300">
</p>

<h2>last 10 days</h2>
EOH

Dir.glob("#{IMAGES}/*.mp4").sort.reverse.each do |mp4|
  print <<EOL
<p><video src="#{mp4}" controls width="300" height="200"></video>
EOL
end

print <<EOF
</p>
<hr>
hiroshi . kimura . 0331 @ gmail . com
</div>
</body>
</html>
EOF
