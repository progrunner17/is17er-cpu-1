BAUD = 115200
COM = 1


.PHONY: all
all:
	gcc -o cserver cserver-com.c com_linux.c util.c


.PHONY: echo
echo:
	stty -F /dev/ttyUSB${COM} ${BAUD}
	stty -F /dev/ttyUSB${COM} raw
	cat /dev/stdin > /dev/ttyUSB${COM} | /dev/ttyUSB${COM} 


.PHONY: clean
clean:
	rm cserver
