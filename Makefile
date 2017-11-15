all: install

install:
	install -m 0755 who-is-in.cgi /srv/who-is-in/
	install -m 0644 who-is-in.css /srv/who-is-in/

run:
	./who-is-in.rb && \
	./jpg2mp4.sh && \
	./slow.sh && \
	open slow.mp4

# capture 10 seconds
headless:
	./who-is-in.rb --exit-after 10 && \
	./jpg2mp4.sh && \
	./slow.sh && \
	open slow.mp4

clean:
	${RM} *.mp4
	${RM} images/*.jpg
