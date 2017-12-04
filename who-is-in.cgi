#!/usr/bin/env ruby
#-*-coding: utf-8 -*-

IMAGES="images"
print <<EOH
content-type: text/html

<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
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
<img class='middle' src="#{IMAGES}/current.jpg">
<img class='middle' src="#{IMAGES}/current-1.jpg">
</p>

<h2>last 9 days</h2>
<p>
EOH

Dir.glob("#{IMAGES}/*.mp4").sort.reverse[0,9].each do |mp4|
  print <<EOL
<video class='small' src="#{mp4}" controls></video>
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
