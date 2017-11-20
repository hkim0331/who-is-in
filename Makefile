all: install

install:
	mkdir -p /opt/who-is-in/{bin,images}
	install -m 0755 who-is-in.rb restart.sh /opt/who-is-in/bin
	install -m 0755 who-is-in.cgi /srv/who-is-in/
	install -m 0644 who-is-in.css /srv/who-is-in/
	@echo check crobtab by 'crobtab -e'

# capture 10 seconds
test:
	./who-is-in.rb --exit-after 10 && \
	./jpg2mp4.sh && \
	open out.mp4

clean:
	${RM} *.mp4
	${RM} images/*.jpg
