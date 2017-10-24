all: run

clean:
	${RM} *.mp4
	${RM} images/*.jpg

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
