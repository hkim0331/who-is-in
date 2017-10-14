all: run

clean:
	${RM} *.mp4
	${RM} images/*.jpg

run:
	make clean
	./who-is-in.rb --with-date && ./jpg2mp4.sh && ./slow.sh && open slow.mp4

# how to pass hh:mm:ss parameter from 'make'?
headless:
	@echo please try make clean && ./who-is-in.rb --with-date --exit-at hh:mm:ss
