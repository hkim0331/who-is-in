all: run

clean:
	${RM} *.mp4
	${RM} images/*.jpg

run:
	make clean
	./who-is-in.rb && ./jpg2mp4.sh && ./slow.sh && open slow.mp4

headless:
	make clean
	@echo please try ./who-is-in.rb --reset-at hh:mm:ss
